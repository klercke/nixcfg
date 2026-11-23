{
  description = "A Python project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.git-hooks-nix.flakeModule ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        { config, pkgs, ... }:
        let
          devtools = import ./nix/devtools.nix { inherit pkgs; };
        in
        {
          pre-commit.settings = {
            package = pkgs.prek;
            hooks = {
              ruff.enable = true;
              ruff-format.enable = true;
              nixfmt.enable = true;
              statix.enable = true;
              deadnix.enable = true;
              taplo.enable = true;
              typos.enable = true;
              actionlint.enable = true;
              zizmor.enable = true;
              convco.enable = true;
            };
          };

          devShells.default = pkgs.mkShell {
            inherit (devtools) env;
            packages = devtools.packages ++ config.pre-commit.settings.enabledPackages;
            shellHook = config.pre-commit.installationScript;
          };

          formatter = pkgs.nixfmt;
        };
    };
}
