{
  flake.modules.homeManager.eza = {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      icons = "auto";
      colors = "auto";
      git = true;
      extraOptions = [
        "-lh"
        "--group-directories-first"
      ];
    };
  };
}
