{
  flake.modules.nixos.unfree =
    { config, lib, ... }:
    let
      allowed = pkg: builtins.elem (lib.getName pkg) config.unfree.allowedPackages;
    in
    {
      options.unfree.allowedPackages = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };

      config = {
        nixpkgs.config.allowUnfreePredicate = allowed;

        home-manager.sharedModules = [
          { nixpkgs.config.allowUnfreePredicate = allowed; }
        ];
      };
    };
}
