{ inputs, ... }:
{
  flake.modules.homeManager.stylix =
    { pkgs, ... }:
    {
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
        enableReleaseChecks = false;
        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

        targets = {
          neovim.enable = false;
          hyprland.enable = false;
          waybar.enable = false;
          btop.enable = false;
          firefox = {
            enable = true;
            profileNames = [ "default" ];
          };
        };

        cursor = {
          name = "DMZ-Black";
          size = 20;
          package = pkgs.vanilla-dmz;
        };

        icons = {
          enable = true;
          package = pkgs.papirus-icon-theme;
          dark = "Papirus-Dark";
          light = "Papirus-Light";
        };

        image = pkgs.fetchurl {
          url = "https://gitlab.com/exorcist365/wallpapers/-/raw/master/gruvbox/forest-4.jpg";
          sha256 = "9aaaf046f26644b2b78b21225e66b0e5440f7ed11aaa0df7361c33a59bf25f0b";
        };
      };
    };
}
