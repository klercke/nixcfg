# Everything every desktop or laptop gets.
# Hosts import this and add only what is specific to their hardware or role.
{ config, inputs, ... }:
{
  flake.modules.nixos.workstation =
    { pkgs, ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko
        config.flake.modules.nixos.unfree
        config.flake.modules.nixos.unstable
        config.flake.modules.nixos.lix
        config.flake.modules.nixos.nix
        config.flake.modules.nixos.nh
        config.flake.modules.nixos.nix-ld
        config.flake.modules.nixos.home-manager
        config.flake.modules.nixos.bootloader
        config.flake.modules.nixos.networking
        config.flake.modules.nixos.firewall
        config.flake.modules.nixos.timezone
        config.flake.modules.nixos.i18n
        config.flake.modules.nixos.env
        config.flake.modules.nixos.zsh
        config.flake.modules.nixos.zen
        config.flake.modules.nixos.polkit
        config.flake.modules.nixos.storage-optimization
        config.flake.modules.nixos.zram
        config.flake.modules.nixos.audio
        config.flake.modules.nixos.udisks2
        config.flake.modules.nixos.yubikey
        config.flake.modules.nixos.webusb
        config.flake.modules.nixos.qdmr
        config.flake.modules.nixos.zapp
        config.flake.modules.nixos.rootless-docker
        config.flake.modules.nixos.desktop
        config.flake.modules.nixos.gaming
        config.flake.modules.nixos.netbird
      ];

      environment.systemPackages = [
        pkgs.vim
        pkgs.wget
        pkgs.nom
        pkgs.dix
      ];
    };
}
