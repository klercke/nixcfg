{
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
      "-lah"
      "--group-directories-first"
    ];
  };
}
