{ inputs, ... }:
{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    imports = [
      ./options.nix
      ./ui.nix
      ./plugins.nix
      ./language.nix
      ./rust.nix
      ./nix.nix
    ];

    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };
}
