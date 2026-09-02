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

    # Desktop apps
    calibre
    chromium
    darktable
    firefox
    gimp
    kdePackages.kleopatra
    obs-studio
    obsidian
    kdePackages.okular
    prismlauncher
    thunderbird

    # Gaming
    prismlauncher
    r2modman

    # WM Things
    brightnessctl
    dconf
    grimblast
    pavucontrol
    playerctl
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
