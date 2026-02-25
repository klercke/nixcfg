{
  description = "@klercke/@d0c_z3r0d4y's NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, disko, home-manager, nur, ... }@inputs: let 
    system = "x86_64-linux";
    hosts = [
      { user = "d0c"; hostname = "ptxe-hme-lt-01"; stateVersion = "25.11"; homeStateVersion = "25.11"; }
      { user = "d0c"; hostname = "thor"; stateVersion = "25.11"; homeStateVersion = "25.11"; }
      { user = "kklercke"; hostname = "work-wsl"; stateVersion = "25.05"; homeStateVersion = "25.11"; }
    ];

    makeSystem = { hostname, user, stateVersion }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs stateVersion hostname user;
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      };

      modules = [
        ./hosts/${hostname}/configuration.nix
        disko.nixosModules.disko
      ];
    };

    makeHome = { hostname, user, homeStateVersion }: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit inputs homeStateVersion user hostname;
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      };
      modules = [
        ./home-manager/home.nix
        nur.modules.homeManager.default
      ];      
    };

  in {
    nixosConfigurations = nixpkgs.lib.foldl' (configs: host:
    configs // {
      "${host.hostname}" = makeSystem {
        inherit (host) hostname user stateVersion;
      };
    }) {} hosts;

    homeConfigurations = nixpkgs.lib.foldl' (configs: host:
    configs // {
      "${host.user}@${host.hostname}" = makeHome {
        inherit (host) hostname user homeStateVersion;
      };
    }) {} hosts;
  };
}

