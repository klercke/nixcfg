{ hostname, ... }: {
  imports = [
    ../../hosts/${hostname}/hyprland.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$menu" = "wofi --show drun";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod_SHIFT, Q, killactive"
        "$mainMod_SHIFT, M, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, D, exec, $menu"
      ];
    };
  };
}
