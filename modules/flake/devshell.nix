{ inputs, ... }:
{
  perSystem =
    { system, config, ... }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      inherit (config.checks.pre-commit-check) shellHook enabledPackages;
    in
    {
      devShells.default = pkgs.mkShell {
        inherit shellHook;
        buildInputs = enabledPackages;
      };
    };
}
