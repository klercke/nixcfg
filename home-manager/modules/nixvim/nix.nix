{ ... }:
{
  plugins.lsp.servers.nixd = {
    enable = true;
    settings =
      let
        flake = ''(builtins.getFlake ".")'';
        system = "\${builtins.currentSystem}";
      in
      {
        nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
        options = rec {
          flake-parts.expr = "${flake}.debug.options";
          nixos.expr = "${flake}.nixosConfigurations.desktop.options";
          home-manager.expr = "${nixos.expr}.home-manager.users.type.getSubOptions [ ]";
          nixvim.expr = "${flake}.packages.${system}.nvim.options";
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
}
