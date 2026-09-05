{ lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
      "steam-unwrapped"
    ];

  # Some of these are installed for compat with modding
  environment.systemPackages = with pkgs; [
    protonup-qt
    lutris
    heroic
    bottles
    mangohud
    dotnetCorePackages.runtime_9_0
    protontricks
    winetricks
    xrandr
    p7zip
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

  programs = {
    gamemode.enable = true;

    steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;

      package = pkgs.steam.override {
        extraEnv = {
          GAMEMODRUN = "1";
        };
      };
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
        openssl
        zlib
        stdenv.cc.cc.lib
        fontconfig
        freetype
        libGL
        xorg.libX11
        xorg.libICE
        xorg.libSM
      ];
    };
  };
}
