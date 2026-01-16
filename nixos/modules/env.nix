{
  environment = {
    sessionVariables = rec {
      TERMINAL = "ghostty";
      EDITOR = "nvim";
    };
    pathsToLink = [ "/share/zsh" ];
  };
}
