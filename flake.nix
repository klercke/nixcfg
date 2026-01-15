{
  description = "@klercke/@d0c_z3r0d4y's NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: let 
    system = "x86_64-linux";
    user = "d0c";
    hosts = [
      { hostname = "ptxe-hme-lt-01"; stateVersion = "25.11"; }
    ];

    makeSystem = { hostname, stateVersion }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs stateVersion hostname user;
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
        disko.nixosModules.disko
      ];
    };

  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
    configs // {
      "${host.hostname}" = makeSystem {
        inherit (host) hostname stateVersion;
      };
    }) {} hosts;
  };
}

