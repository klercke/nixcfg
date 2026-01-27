{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          dots_rounding = -1;
          inner_color = "rgba(282828ff)";
          font_color = "rgba(ebdbb2ff)";
          outer_color = "rgba(689d6aff)";
          outline_thickness = 3;
          fade_on_empty = true;
          fade_timeout = 1000;
          placeholder_text = "<i>Input Password...</i>";
          hide_input = false;
          rounding = 10;
          check_color = "rgba(d79921ff)";
          fail_color = "rgba(cc241dff)";
          position = "0, -20";
          halign = "center";
          valign = "center";
          shadow_passes = 10;
          shadow_size = 20;
          shadow_boost = 1.6;
        }
      ];

      label = [
        {
          text = "cmd[update:1000] echo '$TIME'";
          font_size = 70;
          color = "rgba(ebdbb2ff)";
          position = "-50, 20";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
        {
          text = "$USER";
          color = "rgba(ebdbb2ff)";
          font_size = 20;
          position = "-50, 120";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
    };
  };
}
