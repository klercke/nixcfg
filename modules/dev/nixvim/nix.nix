{
  flake.modules.homeManager.nixvim-nix = {
    programs.nixvim.imports = [
      (_: {
        plugins.lsp.servers.nixd = {
          enable = true;
          settings =
            let
              flake = ''(builtins.getFlake "/home/d0c/nixcfg")'';
            in
            {
              nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
              options = rec {
                flake-parts.expr = "${flake}.debug.options";
                nixos.expr = "${flake}.nixosConfigurations.thor.options";
                home-manager.expr = "${nixos.expr}.home-manager.users.type.getSubOptions [ ]";
                nixvim.expr = ''(${flake}.inputs.nixvim.lib.evalNixvim { modules = [ { nixpkgs.hostPlatform = "x86_64-linux"; } ]; }).options'';
              };
              diagnostic = {
                # Suppress noisy warnings
                suppress = [
                  "sema-escaping-with"
                  "var-bind-to-this"
                ];
              };
            };
        };
      })
    ];
  };
}
