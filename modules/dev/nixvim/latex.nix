{
  flake.modules.homeManager.nixvim-latex = {
    programs.nixvim.imports = [
      {
        config.plugins = {
          vimtex = {
            enable = true;
            # TeX comes from the latex HM module so it's on PATH outside nvim too
            texlivePackage = null;
            settings = {
              # zathura (non-simple) needs xdotool, which doesn't work on Wayland
              view_method = "zathura_simple";
              compiler_method = "latexmk";
              quickfix_open_on_warning = 0;
            };
          };
          lsp.servers.texlab.enable = true;
        };
      }
    ];
  };
}
