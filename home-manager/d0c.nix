{ pkgs, lib, ... }: {
  # Allowed unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
  builtins.elem (lib.getName pkg) [
    "obsidian"
  ];

  home.packages = with pkgs; [
    # Categories are sorted alphabetically
    # Packages are soted alphabetically within categories

    # Desktop apps
    firefox
    gimp
    obs-studio
    obsidian
    prismlauncher
    thunderbird
    webcord
    
    # WM Things
    brightnessctl
    dconf
    grimblast
    pavucontrol
    playerctl
  ];
}
