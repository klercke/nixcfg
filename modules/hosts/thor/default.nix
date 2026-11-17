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
      config.flake.modules.nixos.unfree
      config.flake.modules.nixos.elite-dangerous
      inputs.disko.nixosModules.disko
      config.flake.modules.nixos.unstable
      ./_hardware-configuration.nix
      ./_disk-config.nix
      config.flake.modules.nixos.thor-local-packages
      config.flake.modules.nixos.yubikey
      config.flake.modules.nixos.networking
      config.flake.modules.nixos.timezone
      config.flake.modules.nixos.bootloader
      config.flake.modules.nixos.audio
      config.flake.modules.nixos.zsh
      config.flake.modules.nixos.nix
      config.flake.modules.nixos.nh
      config.flake.modules.nixos.i18n
      config.flake.modules.nixos.zen
      config.flake.modules.nixos.home-manager
      config.flake.modules.nixos.env
      config.flake.modules.nixos.nix-ld
      config.flake.modules.nixos.firewall
      config.flake.modules.nixos.storage-optimization
      config.flake.modules.nixos.amdgpu
      config.flake.modules.nixos.gaming
      config.flake.modules.nixos.udisks2
      config.flake.modules.nixos.zram
      config.flake.modules.nixos.rootless-docker
      config.flake.modules.nixos.webusb
      config.flake.modules.nixos.qdmr
      config.flake.modules.nixos.lix
      config.flake.modules.nixos.desktop
      config.flake.modules.nixos.zapp
      config.flake.modules.nixos.sim-controllers
      config.flake.modules.nixos.polkit
      config.flake.modules.nixos.llm-worker
      config.flake.modules.nixos.transmission
    ];

    networking.hostName = "thor";

    system.stateVersion = "25.11";

    users.users.root.initialHashedPassword = "";

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
