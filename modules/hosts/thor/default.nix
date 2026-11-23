{ config, inputs, ... }:
{
  flake.nixosConfigurations.thor = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      config.flake.modules.nixos.thor
      config.flake.modules.nixos.d0c
    ];
  };

  flake.modules.nixos.thor = {
    imports = [
      config.flake.modules.nixos.workstation
      ./_hardware-configuration.nix
      ./_disk-config.nix
      config.flake.modules.nixos.amdgpu
      config.flake.modules.nixos.elite-dangerous
      config.flake.modules.nixos.sim-controllers
      config.flake.modules.nixos.llm-worker
      config.flake.modules.nixos.transmission
    ];

    networking.hostName = "thor";

    system.stateVersion = "25.11";

    protonet.llmWorker = {
      enable = true;
      port = 8467;
    };

    home-manager.sharedModules = [
      config.flake.modules.homeManager.thor-hyprland
      config.flake.modules.homeManager.thor-noctalia
      config.flake.modules.homeManager.thor-umbriel
    ];

    home-manager.users.d0c.imports = [ config.flake.modules.homeManager.elite-dangerous ];
  };
}
