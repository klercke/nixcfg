{
  flake.modules.homeManager.d0c-home-packages =
    {
      pkgs,
      ...
    }:
    let
      stablePkgs = with pkgs; [
        # Categories are sorted alphabetically
        # Packages are soted alphabetically within categories

        # Audio
        blanket

        # CLI utils
        bat
        bat-extras.batman
        croc
        dust
        fd
        fzf
        glow
        imagemagick
        procs
        ripgrep
        tldr
        tree
        unzip
        yt-dlp
        zip
        zoxide

        # Dev tools
        age
        bacon
        dotter
        gh
        glab
        hyperfine
        jq
        just
        lazygit
        psmisc
        sops

        # Misc. desktop tools
        xdg-utils

        # Misc. homelab tools
        caligula
        john
        xorriso # needed for proxmox auto install asst.

        # Networking tools
        bind
        iperf3
        proton-vpn
        tcpdump
        traceroute
        whois
      ];

      unstablePkgs = with pkgs.unstable; [
        # Any time I use a package from nixpkgs-unstable, I will comment why

        opencode # Development happens fast

        proxmox-auto-install-assistant # Testing to see if the latest version fixes my issue with pdm
      ];
    in
    {
      home.packages = stablePkgs ++ unstablePkgs;
    };
}
