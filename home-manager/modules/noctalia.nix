{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      # Managed by Stylix
      #theme = {
      #  mode = "dark";
      #  source = "builtin";
      #   builtin = "gruvbox";
      #};

      wallpaper = {
        enabled = true;
        # Managed by Stylix
        #default.path = "https://gitlab.com/exorcist365/wallpapers/-/raw/master/gruvbox/forest-4.jpg";
        fill_mode = "fit";
      };
    };
  };
}
