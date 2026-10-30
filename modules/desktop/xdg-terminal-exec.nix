{
  flake.modules.homeManager.xdg-terminal-exec = {
    xdg.terminal-exec = {
      enable = true;
      settings = {
        default = [
          "ghostty.desktop"
        ];
      };
    };
  };
}
