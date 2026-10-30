{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;

      settings = {
        merge = {
          conflictStyle = "zdiff3";
        };

        push = {
          autoSetupRemote = true;
        };

        init = {
          defaultBranch = "main";
        };
      };
    };
  };
}
