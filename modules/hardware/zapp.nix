{ inputs, ... }:
{
  flake.modules.nixos.zapp = {
    imports = [ inputs.zapp.nixosModules.default ];
    programs.zapp.enable = true;
  };
}
