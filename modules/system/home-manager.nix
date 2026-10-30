{ inputs, ... }:
{
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.default ];

    home-manager = {
      backupFileExtension = "bak";
      useUserPackages = true;
      sharedModules = [
        inputs.nur.modules.homeManager.default
        {
          nixpkgs.overlays = [ inputs.pyroclear.overlays.default ];
        }
      ];
    };
  };
}
