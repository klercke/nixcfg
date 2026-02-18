{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    # Categories are sorted alphabetically
    # Packages are soted alphabetically within categories

    # Desktop apps
    calibre
    firefox
    gimp
    obs-studio
    obsidian
    prismlauncher
    thunderbird
    webcord

    # Gaming
    r2modman
    
    # WM Things
    brightnessctl
    dconf
    grimblast
    pavucontrol
    playerctl
  ];
}
