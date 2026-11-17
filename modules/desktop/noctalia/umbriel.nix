{ inputs, ... }:
let
  noctalia = cmd: "spawn noctalia msg ${cmd}";

  # Defining [keybinds] replaces Umbriel's built-in set, so every bind is listed here.
  workspaceBinds = builtins.listToAttrs (
    builtins.concatMap
      (n: [
        {
          name = "Mod+${toString (if n == 10 then 0 else n)}";
          value = "workspace-switch ${toString n}";
        }
        {
          name = "Mod+Shift+${toString (if n == 10 then 0 else n)}";
          value = "window-move-to-workspace ${toString n}";
        }
      ])
      [
        1
        2
        3
        4
        5
        6
        7
        8
        9
        10
      ]
  );
in
{
  flake.modules.homeManager.umbriel = {
    imports = [ inputs.umbriel.homeModules.default ];

    programs.umbriel = {
      enable = true;
      package = null; # installed by programs.umbriel in the noctalia-greeter.nix nixos module
      settings = {
        general.autostart = [ "noctalia" ];

        appearance = {
          prefer_no_csd = true;
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

        keybinds = workspaceBinds // {
          # Apps and shell
          "Mod+Return" = {
            action = "spawn ghostty";
            repeat = false;
          };
          "Mod" = noctalia "panel-toggle launcher";
          "Mod+D" = {
            action = noctalia "panel-toggle launcher";
            repeat = false;
          };
          "Mod+S" = noctalia "panel-toggle control-center";
          "Mod+Shift+V" = noctalia "panel-toggle clipboard";
          "Mod+Comma" = noctalia "settings-toggle";
          "Alt+Tab" = noctalia "window-switcher hold";
          "Mod+Shift+S" = noctalia "screenshot-region";
          "Mod+Shift+L" = noctalia "session lock";
          "Mod+Shift+M" = "session-quit";
          "Mod+Shift+Escape" = {
            action = "shortcuts-inhibit-toggle";
            allow_when_inhibited = true;
            repeat = false;
          };

          # Windows
          "Mod+Shift+Q" = {
            action = "window-close";
            repeat = false;
          };
          "Mod+V" = {
            action = "window-toggle-floating";
            repeat = false;
          };
          "Mod+F" = {
            action = "window-toggle-fullscreen";
            repeat = false;
          };
          "Mod+O" = {
            action = "overview-toggle";
            repeat = false;
          };
          "Mod+Alt+T" = "layout-toggle-split";

          "Mod+H" = "window-focus-left";
          "Mod+J" = "window-focus-down";
          "Mod+K" = "window-focus-up";
          "Mod+L" = "window-focus-right";
          "Mod+Left" = "window-focus-left";
          "Mod+Down" = "window-focus-down";
          "Mod+Up" = "window-focus-up";
          "Mod+Right" = "window-focus-right";

          "Mod+Shift+Left" = "window-swap-left";
          "Mod+Shift+Down" = "window-swap-down";
          "Mod+Shift+Up" = "window-swap-up";
          "Mod+Shift+Right" = "window-swap-right";

          # Media keys through Noctalia so its OSD shows
          "XF86AudioRaiseVolume" = {
            action = noctalia "volume-up";
            allow_when_locked = true;
          };
          "XF86AudioLowerVolume" = {
            action = noctalia "volume-down";
            allow_when_locked = true;
          };
          "XF86AudioMute" = {
            action = noctalia "volume-mute";
            allow_when_locked = true;
            repeat = false;
          };
          "XF86AudioPlay" = {
            action = noctalia "media toggle";
            allow_when_locked = true;
            repeat = false;
          };
          "XF86AudioPause" = {
            action = noctalia "media toggle";
            allow_when_locked = true;
            repeat = false;
          };
          "XF86AudioNext" = {
            action = noctalia "media next";
            allow_when_locked = true;
          };
          "XF86AudioPrev" = {
            action = noctalia "media previous";
            allow_when_locked = true;
          };
          "XF86MonBrightnessUp" = {
            action = noctalia "brightness-up";
            allow_when_locked = true;
          };
          "XF86MonBrightnessDown" = {
            action = noctalia "brightness-down";
            allow_when_locked = true;
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

        # Layer-surface blur is off by default; this blurs Noctalia's bar, panels, OSD, etc.
        layer_rule = [
          {
            match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
            blur = true;
            blur_ignore_alpha = 0.6;
            blur_optimized = false;
          }
        ];
      };
    };
  };
}
