{
  flake.modules.homeManager.thor-hyprland = {
    wayland.windowManager.hyprland.settings = {
      monitor = [
        "DP-1, highrr, 0x0, auto"
        "DP-2, preferred, auto-center-left, auto, transform, 1"
      ];
    };
  };
}
