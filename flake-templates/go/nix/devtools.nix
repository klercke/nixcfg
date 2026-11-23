# Language tooling shared by this flake's devShell and nixcfg's portable `go` shell.
{ pkgs }:
{
  packages = [
    pkgs.go
    pkgs.gopls
    pkgs.gotools
    pkgs.delve
    pkgs.golangci-lint
  ];

  # nixpkgs builds Go with GOTOOLCHAIN=local.
  # "auto" lets the go command fetch the toolchain a go.mod asks for when it is
  # newer than nixpkgs' Go.
  env.GOTOOLCHAIN = "auto";
}
