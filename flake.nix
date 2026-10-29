{
  description = "@klercke/@d0c_z3r0d4y's NixOS Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix"; # this was pinned to 26.05 but that doesn't support noctalia
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    pyroclear = {
      url = "github:shreyanth-sureshkrishnaa/pyroclear";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    umbriel = {
      url = "github:noctalia-dev/umbriel";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zapp = {
      url = "github:zsa/zapp";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hlac = {
      url = "gitlab:klercke/homelab-as-code?ref=feature/llm-gateway"; # switch to main once merged
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      nur,
      self,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      hosts = [
        {
          user = "d0c";
          hostname = "ptxe-hme-lt-01";
          stateVersion = "25.11";
          homeStateVersion = "25.11";
        }
        {
          user = "d0c";
          hostname = "thor";
          stateVersion = "25.11";
          homeStateVersion = "25.11";
        }
        {
          user = "kklercke";
          hostname = "work-wsl";
          stateVersion = "25.05";
          homeStateVersion = "25.11";
        }
      ];

      makeSystem =
        {
          hostname,
          user,
          stateVersion,
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              inputs
              stateVersion
              hostname
              user
              ;
            pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
          };

          modules = [
            ./hosts/${hostname}/configuration.nix
            disko.nixosModules.disko
          ];
        };

      makeHome =
        {
          hostname,
          user,
          homeStateVersion,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ inputs.pyroclear.overlays.default ];
          };
          extraSpecialArgs = {
            inherit
              inputs
              homeStateVersion
              user
              hostname
              ;
            pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
          };
          modules = [
            ./home-manager/home.nix
            nur.modules.homeManager.default
          ];
        };

      forEachSystem = nixpkgs.lib.genAttrs [ system ];

    in
    {
      nixosConfigurations = nixpkgs.lib.foldl' (
        configs: host:
        configs
        // {
          "${host.hostname}" = makeSystem {
            inherit (host) hostname user stateVersion;
          };
        }
      ) { } hosts;

      homeConfigurations = nixpkgs.lib.foldl' (
        configs: host:
        configs
        // {
          "${host.user}@${host.hostname}" = makeHome {
            inherit (host) hostname user homeStateVersion;
          };
        }
      ) { } hosts;

      # Run the hooks with `nix fmt`.
      formatter = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          inherit (self.checks.${system}.pre-commit-check) config;
          inherit (config) package configFile;
          script = ''
            ${pkgs.lib.getExe package} run --all-files --config ${configFile}
          '';
        in
        pkgs.writeShellScriptBin "pre-commit-run" script
      );

      # Run the hooks in a sandbox with `nix flake check`.
      # Read-only filesystem and no internet access.
      checks = forEachSystem (system: {
        pre-commit-check = inputs.git-hooks.lib.${system}.run {
          package = nixpkgs.legacyPackages.${system}.prek;
          src = ./.;
          hooks = {
            nixfmt.enable = true;
            deadnix.enable = true;
            statix.enable = true;
            # Stable flake-checker doesn't support 26.05 yet
            #flake-checker.enable = true;
          };
        };
      });

      devShells = forEachSystem (system: {
        default =
          let
            pkgs = nixpkgs.legacyPackages.${system};
            inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
          in
          pkgs.mkShell {
            inherit shellHook;
            buildInputs = enabledPackages;
          };
      });
    };
}
