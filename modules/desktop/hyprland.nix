{ config, ... }:
{
  flake.modules.nixos.hyprland = {
    # Has to be enabled here so the session can be seen
    programs.hyprland.enable = true;
  };

  flake.modules.homeManager.hyprland = {
    imports = [
      config.flake.modules.homeManager.hyprland-main
      config.flake.modules.homeManager.hyprland-binds
    ];
  };
}
