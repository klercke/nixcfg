{
  flake.modules.nixos.transmission =
    # For ISOs, duh.

    # .torrent files get dropped into ~/torrents and the output automagically
    # ends up in ~/torrents/out.
    { pkgs, ... }:

    let
      user = "d0c";
      torrents = "/home/${user}/torrents";
    in
    {
      services.transmission = {
        enable = true;
        package = pkgs.transmission_4;
        inherit user;
        group = "users";
        openPeerPorts = true;

        settings = {
          download-dir = "${torrents}/out";

          incomplete-dir-enabled = true;
          incomplete-dir = "${torrents}/.incomplete";

          # Picked-up torrents are automatically deleted
          trash-original-torrent-files = true;
          watch-dir-enabled = true;
          watch-dir = torrents;

          rpc-bind-address = "127.0.0.1";

          # Stop seeding after a 2.0 share ratio or 24 hours of no activity,
          # whichever comes first.
          ratio-limit-enabled = true;
          ratio-limit = 2.0;
          idle-seeding-limit-enabled = true;
          idle-seeding-limit = 1440;
        };
      };

      # These folders must exist before the service can start
      systemd.tmpfiles.rules = map (dir: "d ${dir} 0755 ${user} users - -") [
        torrents
        "${torrents}/out"
        "${torrents}/.incomplete"
      ];

      # Curses TUI
      environment.systemPackages = [ pkgs.tremc ];
    };
}
