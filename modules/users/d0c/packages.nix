{
  flake.modules.homeManager.d0c-packages =
    {
      pkgs,
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

      unstablePkgs = with pkgs.unstable; [
        # Any time I use a package from nixpkgs-unstable, I will comment why

        # Misc. destkop apps
        music-assistant-desktop # App is alpha
        webcord # Stable version stopped loading for me
      ];
    in
    {
      home.packages = stablePkgs ++ unstablePkgs;
    };
}
