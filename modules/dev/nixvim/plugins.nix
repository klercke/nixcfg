{
  flake.modules.homeManager.nixvim-plugins = {
    programs.nixvim.imports = [
      {
        plugins = {
          indent-o-matic.enable = true;
          indent-blankline.enable = true;
          nix.enable = true;
          lexima.enable = true;
          colorizer.enable = true;
          vim-surround.enable = true;
          conform-nvim = {
            enable = true;
            settings = {
              format_on_save = { };
            };
          };
          telescope = {
            enable = true;
            extensions = {
              zoxide.enable = true;
              fzf-native.enable = true;
              file-browser.enable = true;
            };
          };
          web-devicons.enable = true;
          which-key.enable = true;
          gitblame.enable = true;
          gitignore.enable = true;
        };
      }
    ];
  };
}
