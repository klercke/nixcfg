{ pkgs, lib, ... }: {
  # Allowed unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
  builtins.elem (lib.getName pkg) [
    
  ];

  home.packages = with pkgs; [
    # Categories are sorted alphabetically
    # Packages are soted alphabetically within categories

    # CLI utils
    bat
    bat-extras.batman
    fastfetch
    fzf
    ripgrep
    unzip
    wget
    yt-dlp
    zip
    zoxide
    
    # Dev tools
    bacon
    glab
    hyperfine

    # Networking tools
    bind
    iperf3
    whois
  ];
}
