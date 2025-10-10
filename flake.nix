{
  description = "d0c_z3r0d4y's NixOs Config";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home Manager 
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprpanel
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, ... }@inputs: {
    nixosConfigurations = {
      thor = let
        username = "d0c";
        specialArgs = { inherit username; };
      in
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
              # Import the old/default configuration.nix for legacy config
              ./hosts/thor
              ./users/${username}/nixos.nix

              # Make home-manager a module of NixOS
              home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true; # WHY does this spell "packages" but the line above doesn't???
                
                home-manager.users.${username} = import ./home/core.nix;

                home-manager.backupFileExtension = "bak";

                home-manager.extraSpecialArgs = {
                  inherit inputs;
                };
                
                nixpkgs.overlays = [
                  inputs.hyprpanel.overlay
                  rust-overlay.overlays.default
                ];
              }

              ({ pkgs, ... }: {
                environment.systemPackages = [
                  pkgs.rust-bin.stable.latest.default
                  pkgs.rust-analyzer
                ];
              })
            ];
          };
      };

    };
  }
