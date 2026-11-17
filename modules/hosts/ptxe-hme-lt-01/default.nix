{ config, inputs, ... }:
{
  flake.nixosConfigurations.ptxe-hme-lt-01 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      config.flake.modules.nixos.ptxe-hme-lt-01
      config.flake.modules.nixos.d0c
    ];
  };

  flake.modules.nixos.ptxe-hme-lt-01 = {
    imports = [
      config.flake.modules.nixos.unfree
      inputs.disko.nixosModules.disko
      config.flake.modules.nixos.unstable
      ./_hardware-configuration.nix
      ./_disk-config.nix
      config.flake.modules.nixos.ptxe-hme-lt-01-local-packages
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
      config.flake.modules.nixos.desktop
      config.flake.modules.nixos.gaming
      config.flake.modules.nixos.colemak
    ];

    networking.hostName = "ptxe-hme-lt-01";

    system.stateVersion = "25.11";

    home-manager.sharedModules = [
      config.flake.modules.homeManager.ptxe-hme-lt-01-hyprland
      config.flake.modules.homeManager.ptxe-hme-lt-01-umbriel
    ];
  };
}
