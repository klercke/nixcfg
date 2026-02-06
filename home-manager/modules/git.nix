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
    };

    signing = {
      signByDefault = true;
      key = "249DF839A80D37DD";
    };
  };
}
