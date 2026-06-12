{
  pkgs,
  pkgs-unstable,
  ...
}:
let
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

    # Misc. homelab tools
    xorriso # needed for proxmox auto install asst.

    # Networking tools
    bind
    iperf3
    whois
  ];

  unstablePkgs = with pkgs-unstable; [
    # Any time I use a package from nixpkgs-unstable, I will comment why

    fastfetch # My MR to add 6 colors to the NixOS logo is not in stable nixpkgs yet
    proxmox-auto-install-assistant # Testing to see if the latest version fixes my issue with pdm
  ];
in
{
  home.packages = stablePkgs ++ unstablePkgs;
}
