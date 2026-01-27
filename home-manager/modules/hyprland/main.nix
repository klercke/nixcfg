{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$menu" = "wofi --show drun";
    };
  };
}
