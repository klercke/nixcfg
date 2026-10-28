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
    wineWow64Packages.stable
    xrandr
    p7zip
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "\\\${HOME}/.steam/root/compatibilitytools.d";
    DOTNET_ROOT = "${pkgs.dotnetCorePackages.runtime_9_0}/share/dotnet";
  };

  programs = {
    gamemode.enable = true;

    steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;

      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];

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
        libX11
        libICE
        libSM
        glib
        nss
        nspr
        dbus
        atk
        at-spi2-atk
        at-spi2-core
        cups
        libdrm
        expat
        libxkbcommon
        pango
        cairo
        alsa-lib
        lz4
        libgbm
        libx11
        libxcomposite
        libxdamage
        libxext
        libxfixes
        libxrandr
        libxcb
      ];
    };
  };
}
