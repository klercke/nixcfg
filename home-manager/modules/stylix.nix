{ pkgs, inputs, ... }: {
  imports = [ inputs.stylix.homeModules.stylix ];

  home.packages = with pkgs; [
    # Fonts
    jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    font-awesome
    powerline-fonts
    powerline-symbols
    nerd-fonts.symbols-only
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    targets = {
      neovim.enable = false;
      hyprland.enable = false;
      waybar.enable = false;
      btop.enable = false;
    };

    cursor = {
      name = "DMZ-Black";
      size = 20;
      package = pkgs.vanilla-dmz;
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    image = pkgs.fetchurl {
      url = "raw.githubusercontent.com/lunik1/nixos-logo-gruvbox-wallpaper/refs/heads/master/png/gruvbox-dark-rainbow.png";
      sha256 = "ec232e1139ed8955022a1508749cd7fac7f7178ec6bee5f66bad68e316c4cf0c";
    };
  };
}
