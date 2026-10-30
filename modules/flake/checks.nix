{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      # Run the hooks in a sandbox with `nix flake check`.
      # Read-only filesystem and no internet access.
      checks.pre-commit-check = inputs.git-hooks.lib.${system}.run {
        package = inputs.nixpkgs.legacyPackages.${system}.prek;
        src = ../..;
        hooks = {
          nixfmt.enable = true;
          deadnix.enable = true;
          statix.enable = true;
          # Stable flake-checker doesn't support 26.05 yet
          #flake-checker.enable = true;
        };
      };
    };
}
