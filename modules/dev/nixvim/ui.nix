{
  flake.modules.homeManager.nixvim-ui = {
    programs.nixvim.imports = [
      {
        colorschemes.gruvbox = {
          enable = true;
        };

        plugins.lualine = {
          enable = true;
          settings = {
            options.theme = "auto";
          };
        };

        plugins.rainbow-delimiters = {
          enable = true;
          #settings = {''
          #  local hooks = require "ibl.hooks";
          #''};
        };
      }
    ];
  };
}
