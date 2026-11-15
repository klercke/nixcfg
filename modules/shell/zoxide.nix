{
  flake.modules.homeManager.zoxide = {
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
    };
  };
}
