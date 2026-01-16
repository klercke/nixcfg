{lib, pkgs, ...}: {
  nixpkgs.config.allowUnfreePredicate = pkg:
  builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
    "steam-unwrapped"
  ];

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
