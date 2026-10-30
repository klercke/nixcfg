{
  flake.modules.homeManager.zoxide = {
    programs.zoxide = {
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
