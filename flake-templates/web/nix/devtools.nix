# Language tooling shared by this flake's devShell and nixcfg's portable `web` shell.
# Covers both Hugo and Zola, so drop the one a project doesn't use.
{ pkgs }:
{
  packages = [
    pkgs.hugo
    pkgs.zola
    pkgs.dart-sass
    pkgs.taplo
    pkgs.just
  ];

  env = { };
}
