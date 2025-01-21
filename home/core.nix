{ config, pkgs, inputs, ... }:

{
  home.username = "d0c";
  home.homeDirectory = "/home/d0c";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  #xresources.properties = {
  #  "Xcursor.size" = 16;
  #  "Xft.dpi" = 172;
  #};

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

