{
  flake.modules.nixos.storage-optimization = {
    nix = {
      optimise = {
        automatic = true;
        dates = [ "02:15" ];
      };
    };
  };
}
