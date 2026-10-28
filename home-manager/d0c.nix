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
    gimp
    kdePackages.kleopatra
    obs-studio
    obsidian
    kdePackages.okular
    prismlauncher
    rpi-imager
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
    music-assistant-desktop # App is alpha
    webcord # Stable version stopped loading for me
  ];
in
{
  # Allowed unfree packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "obsidian"
      "edhm-ui"
    ];

  home.packages = stablePkgs ++ unstablePkgs;
}
