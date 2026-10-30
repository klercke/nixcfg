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
        pinentry-curses
      ];

      programs.gpg = {
        enable = true;
      };

      services.gpg-agent = {
        enable = true;
        defaultCacheTtl = 60;
        maxCacheTtl = 120;
        pinentry = {
          package = pkgs.pinentry-curses;
          program = "pinentry-curses";
        };
      };
    };
}
