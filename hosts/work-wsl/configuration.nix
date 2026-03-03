{
  hostname,
  user,
  stateVersion,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    ./local-packages.nix
    ../../nixos/modules/default-wsl.nix
  ];

  wsl = {
    enable = true;
    defaultUser = user;
    ssh-agent.enable = false; # Seems to be broken https://github.com/nix-community/NixOS-WSL/issues/375
  };

  networking.hostName = hostname;

  system.stateVersion = stateVersion;
}
