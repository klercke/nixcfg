{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
let
  stablePkgs = with pkgs; [
    # Categories are sorted alphabetically
    # Packages are soted alphabetically within categories

    # Audio
    blanket

    # CLI utils
    bat
    bat-extras.batman
    croc
    fastfetch
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
    age
    bacon
    glab
    hyperfine
    psmisc
    sops

    # Misc. desktop tools
    kdePackages.kleopatra
    xdg-utils

    # Misc. homelab tools
    xorriso # needed for proxmox auto install asst.
    john

    # Networking tools
    bind
    iperf3
    proton-vpn
    tcpdump
    traceroute
    whois

    # Photography
    darktable
  ];

  unstablePkgs = with pkgs-unstable; [
    # Any time I use a package from nixpkgs-unstable, I will comment why

    # Misc. destkop apps
    webcord
  ];
in
{
  # Allowed unfree packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
    ];

  home.packages = stablePkgs ++ unstablePkgs;
}
