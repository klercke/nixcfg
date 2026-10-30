{ inputs, ... }:
{
  perSystem =
    { system, config, ... }:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      inherit (config.checks.pre-commit-check.config) package configFile;
      script = ''
        ${pkgs.lib.getExe package} run --all-files --config ${configFile}
      '';
    in
    {
      # Run the hooks with `nix fmt`.
      formatter = pkgs.writeShellScriptBin "pre-commit-run" script;
    };
}
