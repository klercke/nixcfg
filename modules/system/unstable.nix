{ inputs, ... }:
let
  unstableOverlay = _: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      inherit (prev) config;
    };
  };
in
{
  flake.modules.nixos.unstable = {
    nixpkgs.overlays = [ unstableOverlay ];

    home-manager.sharedModules = [
      {
        nixpkgs.overlays = [ unstableOverlay ];
      }
    ];
  };
}
