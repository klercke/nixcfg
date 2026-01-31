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
    grimblast
    ripgrep
    unzip
    wget
    yt-dlp
    zip
    zoxide

    # Desktop apps
    firefox
    obs-studio
    obsidian
    prismlauncher
    webcord

    # WM Things
    brightnessctl
    dconf
    pavucontrol
    playerctl
  ];
}
