{ config, ... }:
{
  flake.modules.nixos.desktop = {
    imports = with config.flake.modules.nixos; [
      hyprland
      noctalia-greeter
    ];

    home-manager.sharedModules = with config.flake.modules.homeManager; [
      hyprland
      noctalia
      umbriel
      stylix
      ghostty
      wofi
      xdg-terminal-exec
      firefox
      thunderbird
      mime-apps
    ];
  };
}
