{
  flake.modules.homeManager.nixvim-markdown = {
    programs.nixvim.imports = [
      {
        config.plugins = {
          markview.enable = true;
        };
      }
    ];
  };
}
