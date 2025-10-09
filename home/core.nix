{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];

  home.username = "d0c";
  home.homeDirectory = "/home/d0c";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # General utilities
    jq # JSON processor
    fzf # A command-line fuzzy finder
    which # Shows the path a command will evaluate to
    tree # Displays a file tree. I probably don't need this with eza --tree?
    gnused # sed command
    gnutar # tar command
    p7zip # 7z command
    gawk # awk command
    gnupg # GPG
    iotop # IO monitor
    xplr # File manager
    hyperfine # Command benchmarking tool
    imagemagick # Image manipulatation
    lunarvim # Vim-based IDE

    # Desktop environment
    hyprland # Desktop environmen
    hyprsunset # Blue light filter
    hypridle # Idle daemon to automatically lock screen
    hyprlock # Lockscreen
    hyprpaper # Wallpaper
    fuzzel # Launcher/dmenu replacement

    # Cool kid utilities
    ripgrep # Faster grep/find alternative
    eza # A modern replacement for ls
    bottom # System monitor
    btop # Another system monitor
    glow # Markdown renderer
    bat # cat replacement
    zoxide # cd replacement. Must-have
    tldr # man replacement
    delta # diff replacement
    dust # du replacement (much better!)
    procs # ps replacement

    # Networking
    mtr # A network diagnostic tool
    iperf3 # Speedtest tool
    dnsutils  # Contains dig & nslookup
    ldns # Contains drill, a replacement for dig
    ipcalc  # IP address calculator
    bandwhich # Like top for networking

    # System troubleshooting tools
    pciutils # lspci command
    usbutils # lsusb command

    # Gaming
    lutris # Game launcher
    prismlauncher # Minecraft

    # Rice
    cbonsai # Generates bonsai trees
    neofetch # NixOS btw
    cmatrix # Matrix rain effect
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Konnor Klercke";
    userEmail = "klercke@protonmail.com";
    signing = {
      signByDefault = true;
      key = null; # Let the GPG agent figure out which key to use
    };
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.navigate = true;
      delta.side-by-side = true;
      delta.line-numbers = true;
      delta.hyperlinks = true;
      merge.conflictstyle = "zdiff3";
      core.editor = "lvim";
    };
  };

  # Starship
  programs.starship = {
    enable = true;
  };

  # Ghostty
  programs.ghostty = {
    enable = true;
    };
  home.file.".config/ghostty/config".text = ''
    theme = "GruvboxDark"
    window-decoration = false
  '';

  # Zsh
  programs.zsh = {
    enable = true;
    sessionVariables = {
      EDITOR = "lvim";
    };
    shellAliases = {
      ls = "eza --long --header --group-directories-first --icons --color=always --git --time-style=long-iso";  
      nvim = "lvim";
    };
    initExtra = ''
      # Starship
      eval "$(starship init zsh)"

      # Zoxide
      eval "$(zoxide init zsh --cmd cd)"
      
      # Prefix search
      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "$key[Up]" up-line-or-beginning-search
      bindkey "$key[Down]" down-line-or-beginning-search
    '';
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "ghostty";
      "$launcher" = "fuzzel";

      monitor = [
        "DP-2, 3440x1440@144, auto, 1"
        "HDMI-A-1, 1920x1080@75, auto-left, 1, transform, 1"
      ];

      "$mod" = "SUPER";
      bind = [
        # Kill commands
        "$mod SHIFT, M, exit, "
        "$mod SHIFT, Q, killactive"

        # Utilities + shortcuts
        "$mod, RETURN, exec, $terminal"
        "$mod, SPACE, exec, $launcher"
        "$mod, L, exec, hyprlock"

        # Switch to workspace
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move window to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      exec-once = [
        "${pkgs.hyprpaper}/bin/hyprpaper"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 1;
        "col.active_border" = "rgb(ebdbb2) rgb(d65d0e) 60deg";
        "col.inactive_border" = "rgb(272727)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 8;
        
        active_opacity = 1.0;
        inactive_opacity = 0.9;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };
    };
  };

  # Hyprpanel
  programs.hyprpanel = {
    enable = true;

    # Automatically start with hyprland
    hyprland.enable = true;

    # Appearance
    theme = "gruvbox";

    # Layout
    layout = {
      "bar.layouts" = {
        "0" = {
          left = [ "hypridle" "hyprsunset" "workspaces" "windowtitle" ];
          middle = [ "clock" ];
          right = [ "cpu" "ram" "storage" "netstat" "volume" "systray" "notifications" ];
        };
        "1" = {
          left = [];
          middle = [];
          right = [];
        };
      };
    };

    settings = {
      # Clock
      bar.clock = {
        format = "%Y-%m-%d %H:%M";
      };
      menus.clock.time.military = true;
      menus.clock.weather.enabled = false;

      # Netstat
      bar.customModules.netstat = {
        dynamicIcon = false;
        leftClick = "hyprctl dispatch exec \"[float] ghostty -e bandwhich\"";
      };

      # Disk usage
      bar.customModules.storage = {
        # TODO: Figure out how to preserve colored output
        leftClick = "hyprctl dispatch exec \"[float] ghostty -e zsh -c 'dust | less'\"";
      };

      # CPU
      bar.customModules.cpu = {
        leftClick = "hyprctl dispatch exec \"[float] ghostty -e btop\"";
      };

      # Memory
      bar.customModules.ram = {
        leftClick = "hyprctl dispatch exec \"[float] ghostty -e btop\"";
      };

      # Hyprsunset
      bar.customModules.hyprsunset = {
        temperature = "3000k";
      };

      # Appearance
      bar.launcher.icon = "󱄅";

      # Scaling
      theme.bar.menus.menu.battery.scaling = 65;
      theme.bar.menus.menu.bluetooth.scaling = 65;
      theme.bar.menus.menu.clock.scaling = 65;
      theme.bar.menus.menu.dashboard.scaling = 65;
      theme.bar.menus.menu.media.scaling = 65;
      theme.bar.menus.menu.network.scaling = 65;
      theme.bar.menus.menu.notifications.scaling = 65;
      theme.bar.menus.menu.power.scaling = 65;
      theme.bar.menus.menu.volume.scaling = 65;
      theme.bar.menus.popover.scaling = 65;
      theme.bar.scaling = 65;
      theme.notification.scaling = 65;
      theme.osd.scaling = 65;
      theme.tooltip.scaling = 65;
    };
  };

  # Btop
  programs.btop.settings = {
    color_theme = "gruvbox_dark_v2";
  };

  # Hypridle
  home.file.".config/hypr/hypridle.conf".text = ''
    general {
      lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
      before_sleep_cmd = loginctl lock-session    # lock before suspend.
      after_sleep_cmd = hyprctl dispatch dpms on  # to avoid having to press a key twice to turn on the display.
    }

    listener {
      timeout = 300                                 # 5min
      on-timeout = loginctl lock-session            # lock screen when timeout has passed
    }

    listener {
      timeout = 1800                                # 30min
      on-timeout = systemctl suspend-then-hibernate # suspend pc
    }
  '';

  # Hyprlock
  home.file.".config/hypr/hyprlock.conf".text = ''
    general {
      grace = 5
      hide_cursor = true
    }

    animations {
      enabled = true
      bezier = linear, 1, 1, 0, 0
      animation = fadeIn, 1, 5, linear
      animation = fadeOut, 1, 5, linear
    }

    input-field {
      monitor =
      size = 250, 60
      outline_thickness = 2
      outer_color = rgba(177, 98, 134, 1)
      dots_size = 0.1 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 1 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true
      inner_color = rgba(40, 40, 40, 1)
      font_color = rgba(235, 219, 178, 1)
      shadow_pass = 2
      fade_on_empty = false
      font_family = JetBrains Mono Nerd Font Mono
      placeholder_text = <span foreground="##cdd6f4"> $USER</span>
      hide_input = false
      position = 0, -300
      halign = center
      valign = center
      zindex = 10
      fail_color = rgba(204, 36, 29, 1)
      check_color = rgba(215, 153, 33, 1)
    }

    background {
      monitor =
      path = ~/wallpaper.png
      blur_passes = 2
    }

    # clock
    label {
      monitor =
      text = cmd[update:1000] echo -e "$(date +"%H:%M")"
      color = rgba(235, 219, 178, 1)
      shadow_pass = 2
      shadow_size = 3
      shadow_color = rgb(0, 0, 0)
      shadow_boost = 1.2
      font_size = 100
      position = 0, -200
      halign = center
      valign = top
      font_family = JetBrainsMono Nerd Font Mono ExtraBold
    }
  '';
  
  # Hyprpaper
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/wallpaper.png
    wallpaper = , ~/wallpaper.png
  '';

  # Set xplr as file explorer
  programs.xplr.enable = true;

  # Fuzzel
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.ghostty}/bin/ghostty";
      };
      colors = {
        background = "282828ff";
        text = "ebdbb2ff";
        match = "fabd2fff";
        selection = "458588ff";
        selection-text = "ebdbb2ff";
        border = "665c54ff";
      };
      border = {
        width = 2;
      };
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

