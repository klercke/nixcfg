{ config, inputs, ... }:
{
  flake.nixosConfigurations.freyr = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      config.flake.modules.nixos.freyr
      config.flake.modules.nixos.d0c
    ];
  };

  flake.modules.nixos.freyr = {
    imports = [
      config.flake.modules.nixos.workstation
      ./_hardware-configuration.nix
      ./_disk-config.nix
      config.flake.modules.nixos.colemak
    ];

    networking.hostName = "freyr";

    system.stateVersion = "25.11";

    home-manager.sharedModules = [
      config.flake.modules.homeManager.freyr-hyprland
      config.flake.modules.homeManager.freyr-umbriel
    ];
  };
}
