{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$menu" = "wofi --show drun";

      exec-once = [
        "waybar"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        "col.active_border" =
          "rgba(fb4934ee) rgba(fe8019ee) rgba(fabd2fee) rgba(83a598ee) rgba(d3869bee) 45deg";
        "col.inactive_border" = "rgba(a89984aa)";

        resize_on_border = true;

        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        rounding_power = 4;

        active_opacity = .95;
        inactive_opacity = .75;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(282828ee)";
        };

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
      };

      dwindle = {
        preserve_split = true;
        force_split = 2;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };
  };
}
