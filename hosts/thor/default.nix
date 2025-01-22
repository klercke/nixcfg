{ 
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Include modules
      ../../modules/system.nix
      ../../modules/yubikey-gpg.nix
    ];

  # === Boot Options ===

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Disk encryption
  boot.initrd.luks.devices."luks-2404762d-fc4e-452c-b4a3-ee754fc787dc".device = "/dev/disk/by-uuid/2404762d-fc4e-452c-b4a3-ee754fc787dc";

  # Use Zen kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # === Networking ===

  # Set hostname
  networking.hostName = "thor";

  # Enable networking
  networking.networkmanager.enable = true;

  # === Desktop Environment ===

  # Enable X11
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
