{
  description = "IaC Dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.11";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }@inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
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

      checks = forEachSystem (system: {
        pre-commit-check = inputs.git-hooks.lib.${system}.run {
          package = nixpkgs.legacyPackages.${system}.prek;
          src = ./.;
          hooks = {
            terraform-format.enable = true;
            terraform-validate.enable = true;
            tflint.enable = true;
          };
          rawConfig = {
            repos = [
              {
                "repo" = "https://github.com/antonbabenko/pre-commit-terraform";
                "rev" = "v1.96.2";
                "hooks" = [
                  {
                    "id" = "terraform_docs";
                    "name" = "Terraform docs";
                    "require_serial" = true;

                  }
                ];
              }
            ];
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
            buildInputs = [
              pkgs.python313
              pkgs.opentofu
              pkgs.azure-cli
              pkgs.terraform-docs
              pkgs.tflint
            ]
            ++ enabledPackages;
          };
      });
    };
}
