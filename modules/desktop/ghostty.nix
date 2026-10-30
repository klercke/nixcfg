{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = {
        theme = "Gruvbox Dark Hard";
        font-size = 11;
      };
    };
  };
}
