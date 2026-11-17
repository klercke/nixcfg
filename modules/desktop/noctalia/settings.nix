{ inputs, ... }:
{
  flake.modules.homeManager.noctalia = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;

      settings = {
        # Managed by Stylix
        #theme = {
        #  mode = "dark";
        #  source = "builtin";
        #   builtin = "gruvbox";
        #};

        wallpaper = {
          enabled = true;
          # Managed by Stylix
          #default.path = "https://gitlab.com/exorcist365/wallpapers/-/raw/master/gruvbox/forest-4.jpg";
          fill_mode = "fill";
        };

        location = {
          auto_locate = true;
          address = "Rochester, NY";
        };

        weather.unit = "imperial";

        nightlight.enabled = true;

        widget = {
          media = {
            hide_when_no_media = true;
            hide_when_idle = true;
          };

          gpu = {
            type = "sysmon";
            stat = "gpu_vram";
          };
        };

        system.monitor = {
          gpu_vram_activity_threshold = 80;
          gpu_vram_critical_threshold = 95;
        };

        shell = {
          greeter_sync.auto_sync = true;
          polkit_agent = true;

          # Umbriel overview: start typing to search, close it when an app launches
          umbriel_overview_type_to_launch_enabled = true;
          umbriel_overview_close_on_launch_enabled = true;

          launcher = {
            # Type a window title in the main search to jump to it
            providers.windows.global = true;
            # "reboot", "lock", etc. without the /session prefix
            providers.session.global = true;
          };

          window_switcher.mru = true;
        };

        # No [bar] table means Noctalia uses one bar named "default".
        # battery and brightness hide themselves where there's nothing to show (thor).
        bar.default = {
          start = [
            "launcher"
            "workspaces"
          ];
          center = [
            "clock"
          ];
          end = [
            "weather"
            "cpu"
            "ram"
            "gpu"
            "media"
            "tray"
            "notifications"
            "clipboard"
            "network"
            "bluetooth"
            "volume"
            "brightness"
            "battery"
            "control-center"
            "session"
          ];
        };
      };
    };
  };
}
