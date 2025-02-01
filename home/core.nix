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
    gawk # awk command
    gnupg # GPG
    iotop # IO monitor
    xplr # File manager
    hyperfine # Command benchmarking tool

    # Desktop environment
    hyprland
    hyprsunset
    hypridle
    hyprlock

    # Cool kid utilities
    ripgrep # Faster grep/find alternative
    eza # A modern replacement for ls
    bottom # System monitor
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
  '';

  # Zsh
  programs.zsh = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      ls = "eza --long --header --group-directories-first --icons --color=always --git --time-style=long-iso";  
    };
    initExtra = ''
      # Starship
      eval "$(starship init zsh)"

      # Zoxide
      eval "$(zoxide init zsh --cmd cd)"
    '';
  };

  # Neovim
  programs.neovim = {
    defaultEditor = true;
  };

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "ghostty";

      monitor = [
        "DP-2, 3440x1440@144, auto, 1"
        "HDMI-A-1, 1920x1080@75, auto-left, 1, transform, 1"
      ];

      "$mod" = "SUPER";
      bind = [
        "$mod, F, exec, firefox"
        "$mod, M, exit, "
        "$mod, RETURN, exec, $terminal"
      ];
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
          left = [ "dashboard" "hypridle" "hyprsunset" "workspaces" "windowtitle" ];
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

      # Netstat
      bar.customModules.netstat = {
        dynamicIcon = true;
        leftClick = "hyprctl dispatch exec \"[float] ghostty -e bandwhich\"";
      };

      # Disk usage
      bar.customModules.storage = {
        # TODO: Figure out how to preserve colored output
        leftClick = "hyprctl dispatch exec \"[float] ghostty -e zsh -c 'dust | less'\"";
      };

      # Appearance
      bar.launcher.icon = "󱄅";

      # Disable weather
      menus.clock.weather.enabled = false;

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

