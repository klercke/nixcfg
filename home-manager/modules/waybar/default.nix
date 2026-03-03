{
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "idle_inhibitor"
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "cpu"
          "memory"
          "disk"
          "network"
          "pulseaudio"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          show-special = true;
          special-visible-only = true;
          all-outputs = false;
        };

        "cpu" = {
          format = " {usage}%";
          on-click = "ghostty -e btop";
          states = {
            warning = 50;
            critical = 90;
          };
        };

        "memory" = {
          format = " {percentage}%";
          tooltip-format = "{used}GiB/{total}GiB used ({percentage}%)";
          on-click = "ghostty -e btop";
          states = {
            warning = 50;
            critical = 90;
          };
        };

        "disk" = {
          format = "󰋊 /home {percentage_used}%";
          path = "/home";
          states = {
            warning = 75;
            critical = 90;
          };
        };

        "network" = {
          interval = 1;
          format-disconnected = "󰈂 {ifname} (disconnected)";
          format-disabled = "󰈂 {ifname} (disabled)";
          format-linked = "󰈀 {ifname} (linked)";
          format-wifi = "󰛴 {bandwidthDownBytes} 󰛶 {bandwidthUpBytes}  󰀂 {essid} ({signalStrength}%)";
          format-ethernet = "󰛴 {bandwidthDownBytes} 󰛶 {bandwidthUpBytes}";
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-muted = "";
          format-icons = {
            "headphones" = "";
            "handsfree" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 1;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        "clock" = {
          format = "{:%F %R}";
          format-alt = "{:%Y-%m-%dT%H:%M:%S%z}";
        };

        "tray" = {
          icon-size = 14;
          spacing = 1;
        };
      };
    };
  };
}
