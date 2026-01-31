{ pkgs, ...}: {
  plugins = {
    treesitter = {
      enable = true;
      settings.highlight.enable = true;
      settings.indent.enable = true;
      folding = false;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        regex
        rust
        toml
        vim
        vimdoc
        xml
        yaml
      ];
    };
  };
}
