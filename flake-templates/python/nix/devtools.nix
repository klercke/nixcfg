# Language tooling shared by this flake's devShell and nixcfg's portable `python` shell.
# uv manages the project venv.
# These settings make it use the Nix-provided interpreter instead of
# downloading its own.
{ pkgs }:
let
  python = pkgs.python3;
in
{
  packages = [
    python
    pkgs.uv
    pkgs.ruff
  ];

  env = {
    UV_PYTHON = python.interpreter;
    UV_PYTHON_DOWNLOADS = "never";
  };
}
