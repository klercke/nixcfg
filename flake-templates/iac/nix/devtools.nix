# Language tooling shared by this flake's devShell and nixcfg's portable `iac` shell.
{ pkgs }:
{
  packages = [
    pkgs.opentofu
    pkgs.tflint
    pkgs.terraform-ls
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.yamllint
    pkgs.check-jsonschema
    pkgs.sops
    pkgs.age
    pkgs.just
  ];

  env = { };
}
