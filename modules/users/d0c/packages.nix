{
  flake.modules.homeManager.d0c-packages =
    {
      pkgs,
      ...
    }:
    let
      stablePkgs = with pkgs; [
        # Categories are sorted alphabetically
        # Packages are sorted alphabetically within categories

        # 3D Printing
        orca-slicer

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
        qrencode
        ripgrep
        tldr
        tree
        unzip
        yt-dlp
        yubikey-manager
        zip

        # Desktop apps
        calibre
        chromium
        darktable
        gimp
        kdePackages.kleopatra
        obs-studio
        obsidian
        kdePackages.okular
        rpi-imager

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
        openssl
        psmisc
        sops

        # Gaming
        prismlauncher
        r2modman

        # Homelab tools
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

        # WM things
        brightnessctl
        dconf
        pavucontrol
        playerctl
        xdg-utils
      ];

      unstablePkgs = with pkgs.unstable; [
        # Any time I use a package from nixpkgs-unstable, I will comment why

        music-assistant-desktop # App is alpha
        opencode # Development happens fast
        proxmox-auto-install-assistant # Testing to see if the latest version fixes my issue with pdm
        webcord # Stable version stopped loading for me
      ];
    in
    {
      home.packages = stablePkgs ++ unstablePkgs;
    };
}
