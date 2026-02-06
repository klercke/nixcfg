{ pkgs, lib, ... }: {
  # Allowed unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
  builtins.elem (lib.getName pkg) [
    "obsidian"
  ];

  home.packages = with pkgs; [
    # Categories are sorted alphabetically
    # Packages are soted alphabetically within categories

    # CLI utils
    fastfetch
    fzf
    ripgrep
    unzip
    wget
    yt-dlp
    zip
    zoxide

    # Desktop apps
    firefox
    gimp
    obs-studio
    obsidian
    prismlauncher
    thunderbird
    webcord
    
    # Dev tools
    bacon
    direnv

    # Networking tools
    bind
    iperf3

    # WM Things
    brightnessctl
    dconf
    grimblast
    pavucontrol
    playerctl
  ];
}
