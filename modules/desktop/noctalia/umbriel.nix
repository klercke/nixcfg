{ inputs, ... }:
{
  flake.modules.homeManager.umbriel = {
    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel = {
      enable = true;
      package = null; # installed in the noctalia-greeter.nix nixos module
      settings = {
        general.autostart = [ "noctalia" ];

        appearance = {
          border_width = 2;
          corner_radius = 8;
          blur = {
            enabled = true;
            passes = 3;
            radius = 8;
          };
          shadow = {
            enabled = true;
            softness = 10;
          };
        };

        layout = {
          mode = "dwindle";
          gap = 5;
          dwindle.preserve_split = true;
        };

        animation.dim_unfocused = {
          enabled = true;
          dim = 0.25;
        };

        keybinds = {
          "Mod+Return" = "spawn:ghostty";
          "Mod+D" = "spawn:wofi --show drun";
          "Mod+Q" = "window-close";
          "Mod+O" = {
            action = "overview-toggle";
            repeat = false;
          };
        };

        window_rule = [
          {
            blur = true;
            blur_optimized = false;
          }
          {
            match.app_id = "^dev.noctalia.Noctalia$";
            default_floating = true;
            default_size = [
              1020
              900
            ];
          }
          {
            match.app_id = "^dev.noctalia.UmbrielSharePicker$";
            default_floating = true;
            default_size = [
              800
              600
            ];
          }
        ];
      };
    };
  };
}
