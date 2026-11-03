{ config, inputs, ... }:
{
  flake.modules.homeManager.nixvim = {
    imports = [
      inputs.nixvim.homeModules.nixvim
      config.flake.modules.homeManager.nixvim-options
      config.flake.modules.homeManager.nixvim-ui
      config.flake.modules.homeManager.nixvim-plugins
      config.flake.modules.homeManager.nixvim-language
      config.flake.modules.homeManager.nixvim-rust
      config.flake.modules.homeManager.nixvim-nix
      config.flake.modules.homeManager.nixvim-markdown
      config.flake.modules.homeManager.nixvim-latex
    ];

    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
    };
  };
}
