{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [
      gcc
      nodejs
      go
      python3
      statix
      cargo
      curl
      fzf
      ripgrep
      fd
    ];
  };
}
