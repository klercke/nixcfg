# LLM worker for the ProtoNet gateway.
#
# Model choices live in hlac's registries/models.yaml; this module turns the
# entries for one worker into a llama-swap config. The worker's address comes
# from hlac's generated hlac.json, so nothing here duplicates the registry.
#
# Enable per host:
#   protonet.llmWorker.enable = true;
#
# The worker name defaults to the hostname, so the host needs a matching key
# under `workers:` in models.yaml and an entry in devices.yaml.
#
# Needs the hlac repo as a flake input (flake = false) in `inputs.hlac`, and
# `pkgs-unstable` for current llama.cpp / llama-swap builds.
{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:

let
  cfg = config.protonet.llmWorker;
  inherit (inputs) hlac;

  registry =
    (builtins.fromJSON (
      builtins.readFile "${hlac}/ansible/inventories/protonet/group_vars/all/hlac.json"
    )).hlac;

  device = registry.devices.${cfg.name} or null;
  gateway = registry.hosts.${cfg.gateway} or null;
  listenAddress = if device == null then null else device.ipv4;
  gatewayAddress = if gateway == null then null else gateway.ipv4;
  workerUrl = "http://${toString listenAddress}:${toString cfg.port}";

  llama =
    if cfg.acceleration == "rocm" then
      pkgs-unstable.llama-cpp.override {
        rocmSupport = true;
        inherit (cfg) rocmGpuTargets;
      }
    else
      pkgs-unstable.llama-cpp.override { vulkanSupport = true; };

  swapConfig =
    pkgs.runCommand "llama-swap-${cfg.name}.yaml"
      {
        nativeBuildInputs = [ pkgs.yq-go ];
        WORKER = cfg.name;
        EXPECTED_URL = workerUrl;
        LLAMA_SERVER = "${llama}/bin/llama-server";
      }
      ''
        models=${hlac}/registries/models.yaml

        # The gateway reaches this worker at the URL in models.yaml; refuse to
        # build if it disagrees with where this host will actually listen.
        url=$(yq '.workers[strenv(WORKER)].url' "$models")
        if [ "$url" != "$EXPECTED_URL" ]; then
          echo "models.yaml has workers.$WORKER.url = $url, but this host listens on $EXPECTED_URL" >&2
          exit 1
        fi

        # healthCheckTimeout covers first use, when llama-server downloads the
        # GGUF before it starts listening.
        yq '{
          "healthCheckTimeout": 1800,
          "models": (.models
            | with_entries(select(.value.worker == strenv(WORKER)))
            | map_values({
                "cmd": strenv(LLAMA_SERVER) + " --port ''${PORT} -hf " + .hf
                       + " -ngl 99 -c " + (.ctx | tostring) + " --jinja",
                "ttl": .ttl
              }))
        }' "$models" > $out
      '';
in
{
  options.protonet.llmWorker = {
    enable = lib.mkEnableOption "this host as a llama-swap worker for the ProtoNet LLM gateway";

    name = lib.mkOption {
      type = lib.types.str;
      default = config.networking.hostName;
      defaultText = lib.literalExpression "config.networking.hostName";
      description = "Worker key in models.yaml and device key in devices.yaml.";
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 8080;
      description = "Port llama-swap listens on. Must match the worker URL in models.yaml.";
    };

    gateway = lib.mkOption {
      type = lib.types.str;
      default = "llm01";
      description = "Host in hosts.yaml allowed to reach the worker.";
    };

    acceleration = lib.mkOption {
      type = lib.types.enum [
        "vulkan"
        "rocm"
      ];
      default = "vulkan";
      description = "llama.cpp GPU backend. Vulkan builds far faster; ROCm can be quicker on supported cards.";
    };

    rocmGpuTargets = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "gfx1030" ];
      description = "GPU architectures to build for when acceleration is rocm. Fewer targets build faster.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = device != null && listenAddress != null;
        message = "protonet.llmWorker: no device '${cfg.name}' with an address in hlac's devices.yaml.";
      }
      {
        assertion = gateway != null;
        message = "protonet.llmWorker: no host '${cfg.gateway}' in hlac's hosts.yaml.";
      }
    ];

    systemd.services.llama-swap = {
      description = "llama-swap LLM worker for ${cfg.gateway}";
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];

      environment.LLAMA_CACHE = "/var/lib/llama-swap/models";

      serviceConfig = {
        ExecStart =
          "${pkgs-unstable.llama-swap}/bin/llama-swap"
          + " --config ${swapConfig}"
          + " --listen ${toString listenAddress}:${toString cfg.port}";
        DynamicUser = true;
        StateDirectory = "llama-swap";
        SupplementaryGroups = [
          "render"
          "video"
        ];
        # The address can arrive after network-online on a DHCP desktop
        Restart = "on-failure";
        RestartSec = 5;
      };
    };

    # llama-swap has no auth: only the gateway may reach it, even from the
    # same VLAN.
    networking.firewall = lib.mkMerge [
      (lib.mkIf config.networking.nftables.enable {
        extraInputRules = ''
          ip saddr ${toString gatewayAddress} tcp dport ${toString cfg.port} accept
        '';
      })
      (lib.mkIf (!config.networking.nftables.enable) {
        extraCommands = ''
          iptables -A nixos-fw -p tcp -s ${toString gatewayAddress} --dport ${toString cfg.port} -j nixos-fw-accept
        '';
        extraStopCommands = ''
          iptables -D nixos-fw -p tcp -s ${toString gatewayAddress} --dport ${toString cfg.port} -j nixos-fw-accept || true
        '';
      })
    ];
  };
}
