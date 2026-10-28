{ inputs, ... }:
{
  imports = [ inputs.zapp.nixosModules.default ];
  programs.zapp.enable = true;
}
