{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Konnor Klercke";
        email = "klercke@protonmail.com";
      };
      
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

    signing = {
      signByDefault = true;
      key = "249DF839A80D37DD";
    };
  };
}
