{
  flake.modules.homeManager.thor-noctalia = {
    programs.noctalia.settings = {
      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@DP-2"
          "lockscreen-login-box@DP-1"
          "lockscreen-widget-0000000000000001"
        ];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget = {
          "lockscreen-login-box@DP-1" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 1720.0;
            cy = 1258.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 3440.0;
            rotation = 0.0;
            type = "login_box";

            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };

          "lockscreen-login-box@DP-2" = {
            box_height = 196.0;
            box_width = 810.0;
            cx = 540.0;
            cy = 1738.0;
            output = "DP-2";
            placement_height = 1920.0;
            placement_width = 1080.0;
            rotation = 0.0;
            type = "login_box";

            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };

          lockscreen-widget-0000000000000001 = {
            box_height = 176.0;
            box_width = 448.0;
            cx = 1720.0;
            cy = 312.0;
            output = "DP-1";
            placement_height = 1440.0;
            placement_width = 3440.0;
            rotation = 0.0;
            type = "clock";

            settings.clock_style = "digital";
          };
        };
      };
    };
  };
}
