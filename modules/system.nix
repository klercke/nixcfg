{
  pkgs,
  lib,
  username,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.d0c = {
    isNormalUser = true;
    description = "d0c_z3r0d4y";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      zsh
      steam
    ];
  };

  # Automatic weekly garbage collection
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };
}
