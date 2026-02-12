{ pkgs, lib, ... }: {
  # Allowed unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
  builtins.elem (lib.getName pkg) [
    
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
    
    # Dev tools
    bacon
    glab

    # Networking tools
    bind
    iperf3
    whois
  ];
}
