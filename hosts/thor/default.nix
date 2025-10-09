{ config,
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

  # Load kernel modules
  # coretemp, jc42, and nct6775 are for lm_sensors
  boot.kernelModules = [ "coretemp" "jc42" "nct6775" ];

  # === Networking ===

  # Set hostname
  networking.hostName = "thor";

  # Enable networking
  networking.networkmanager.enable = true;

  # Disable IPv6
  networking.enableIPv6 = false;

  # === Desktop Environment ===

  # Enable X11
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Disable GNOME
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

  # Enable Greetd
  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland --remember --remember-user-session";
        user = "greeter";
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
