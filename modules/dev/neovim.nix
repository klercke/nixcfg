# Neovim with the plain Lua config in nvim/ at the repo root.
# The config is linked out of the store, so edits apply on the next nvim start without a rebuild.
# That also lets vim.pack write nvim-pack-lock.json back into the repo.
{
  flake.modules.homeManager.neovim =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      # Tools the config expects on every machine.
      # They go on the end of nvim's PATH, so a devShell's copies win.
      tools = with pkgs; [
        curl
        gcc
        tree-sitter
        lua-language-server
        marksman
        nixd
        nixfmt
        stylua
        taplo
        texlab
      ];

      nvim = pkgs.symlinkJoin {
        name = "nvim-${pkgs.neovim-unwrapped.version}";
        paths = [ pkgs.neovim-unwrapped ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/nvim --suffix PATH : ${lib.makeBinPath tools}
        '';
      };
    in
    {
      home = {
        packages = [ nvim ];
        sessionVariables.EDITOR = "nvim";
        shellAliases = {
          vi = "nvim";
          vim = "nvim";
          vimdiff = "nvim -d";
        };
      };

      xdg.configFile."nvim".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixcfg/nvim";
    };
}
