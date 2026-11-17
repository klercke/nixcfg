{
  flake.modules.nixos.yubikey =
    { pkgs, ... }:

    {
      services.pcscd.enable = true;

      environment.systemPackages = with pkgs; [
        gnupg
        pinentry-curses
      ];
    };

  flake.modules.homeManager.gpg =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        pinentry-qt
      ];

      programs.gpg = {
        enable = true;
        scdaemonSettings = {
          disable-ccid = true;
        };
      };

      services.gpg-agent = {
        enable = true;
        defaultCacheTtl = 60;
        maxCacheTtl = 120;
        pinentry = {
          package = pkgs.pinentry-qt;
          program = "pinentry-qt";
        };
      };
    };
}
