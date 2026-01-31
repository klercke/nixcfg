{
  environment = {
    sessionVariables = rec {
      TERMINAL = "ghostty";
      EDITOR = "nvim";
      XDG_PICTURES_DIR = "~/Pictures";
      XDG_screenshots_DIR = "~/Pictures/Screenshots";
    };
    pathsToLink = [ "/share/zsh" ];
  };
}
