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
      config.flake.modules.nixos.workstation
      ./_hardware-configuration.nix
      ./_disk-config.nix
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
