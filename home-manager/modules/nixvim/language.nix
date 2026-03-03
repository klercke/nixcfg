{ lib, pkgs, ... }:
{
  config.plugins = {
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
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        pyright.enable = true;
        rust_analyzer.enable = false; # Rustaceanvim handles this
        statix.enable = true;
        nixd.enable = true;
      };
    };
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "luasnip"; }
        { name = "nvim-lua"; }
        { name = "conventionalcommits"; }
        { name = "git"; }
      ];
    };
  };
  config.extraConfigLua = ''
    vim.diagnostic.config({
      virtual_text = {
        spacing = 2,
      },
      update_in_insert = false,
    })
  '';
}
