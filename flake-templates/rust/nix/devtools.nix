# Language tooling shared by this flake's devShell and nixcfg's portable `rust` shell.
# The toolchain itself is not listed here.
# This flake builds it from rust-toolchain.toml and the portable shell uses
# rustup so it follows whatever toolchain file the project has.
{ pkgs }:
{
  packages = [
    pkgs.cargo-nextest
    pkgs.cargo-deny
    pkgs.cargo-watch
    pkgs.cargo-edit
    pkgs.taplo
  ];

  env = { };
}
