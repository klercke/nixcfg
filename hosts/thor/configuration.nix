# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ hostname, stateVersion, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ./local-packages.nix
    ../../nixos/modules
    ../../nixos/modules/amdgpu.nix
    ../../nixos/modules/gaming.nix
    ../../nixos/modules/udisks2.nix
    ../../nixos/modules/zram.nix
    ../../nixos/modules/rootless_docker.nix
  ];

  users.users.root.initialHashedPassword = "";

  networking.hostName = hostname;

  system.stateVersion = stateVersion;
}
