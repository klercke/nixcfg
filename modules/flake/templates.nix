# Every directory in flake-templates/ is exposed twice:
#   templates.<lang>  for `nix flake init -t ~/nixcfg#<lang>` in new projects
#   devShells.<lang>  a hook-free shell for working in other people's repos
# Both read the template's nix/devtools.nix, so the tool list lives in one place.
{ inputs, lib, ... }:
let
  dir = ../../flake-templates;
  langs = lib.attrNames (lib.filterAttrs (_: type: type == "directory") (builtins.readDir dir));

  welcome = {
    rust = "Run `cargo init`, then `direnv allow`.";
    go = "Run `go mod init <module>`, then `direnv allow`.";
    python = "Run `uv init`, then `direnv allow`.";
    iac = "Run `direnv allow`.";
    web = "Run `hugo new site . --force` or `zola init .`, then drop the one you don't use from nix/devtools.nix and `direnv allow`.";
  };

  # Extras for the portable shells only.
  # Rust gets rustup so the project's own rust-toolchain.toml decides the toolchain.
  portableExtras = pkgs: {
    rust = [ pkgs.rustup ];
  };
in
{
  flake.templates = lib.genAttrs langs (name: {
    path = dir + "/${name}";
    description = "${name} project with a flake-parts devShell and prek hooks";
    welcomeText = welcome.${name} or "";
  });

  perSystem =
    { system, ... }:
    let
      pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
      shellFor =
        name:
        let
          devtools = import (dir + "/${name}/nix/devtools.nix") { inherit pkgs; };
        in
        pkgs.mkShell {
          inherit (devtools) env;
          packages = devtools.packages ++ ((portableExtras pkgs).${name} or [ ]);
        };
    in
    {
      devShells = lib.genAttrs langs shellFor;
    };
}
