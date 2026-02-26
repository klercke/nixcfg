{ pkgs, pkgs-unstable, lib, ... }:
let 
  # Allowed unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
  builtins.elem (lib.getName pkg) [
    "obsidian"
  ];

  stablePkgs = with pkgs; [
    # Categories are sorted alphabetically
    # Packages are soted alphabetically within categories

    # CLI utils
    bat
    bat-extras.batman
    fd
    fzf
    imagemagick
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

  unstablePkgs = with pkgs-unstable; [
    # Any time I use a package from nixpkgs-unstable, I will comment why

    fastfetch # My MR to add 6 colors to the NixOS logo is not in stable nixpkgs yet
  ];
in {
  home.packages = stablePkgs ++ unstablePkgs;
}

