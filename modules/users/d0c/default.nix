{ config, ... }:
{
  flake.modules.nixos.d0c = _: {
    users.users.d0c = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "seat"
        "gamemode"
        "dialout"
      ];
    };

    programs.nh.flake = "/home/d0c/nixcfg";

    unfree.allowedPackages = [ "obsidian" ];

    home-manager.users.d0c = {
      imports = [
        config.flake.modules.homeManager.d0c-home-packages
        config.flake.modules.homeManager.d0c-packages
        config.flake.modules.homeManager.pyroclear
        config.flake.modules.homeManager.zsh
        config.flake.modules.homeManager.zoxide
        config.flake.modules.homeManager.starship
        config.flake.modules.homeManager.eza
        config.flake.modules.homeManager.btop
        config.flake.modules.homeManager.fastfetch
        config.flake.modules.homeManager.git
        config.flake.modules.homeManager.gpg
        config.flake.modules.homeManager.zellij
        config.flake.modules.homeManager.direnv
        config.flake.modules.homeManager.delta
        config.flake.modules.homeManager.nixvim
        config.flake.modules.homeManager.latex
        config.flake.modules.homeManager.opencode
      ];

      programs = {
        zsh.shellAliases = {
          lg = "lazygit";
          cat = "bat";
          find = "fd";
          tf = "tofu";
          man = "batman";
        };

        git = {
          settings = {
            user = {
              name = "Konnor Klercke";
              email = "klercke@protonmail.com";
            };
          };

          signing = {
            signByDefault = true;
            key = "14DD826AC43B2370D1C3BA6A9A0AA323503343D2";
          };
        };

        gpg.publicKeys = [
          {
            source = "${builtins.fetchurl {
              url = "https://z3r0d4y.dev/pgp-key.txt";
              sha256 = "75f7c6e56436582a1dad19007de3516e9975a1e30633c00af3eb6aef89ef994e";
            }}";
            trust = 5;
          }
        ];
      };

      services.gpg-agent.enableSshSupport = true;

      home = {
        username = "d0c";
        homeDirectory = "/home/d0c";
        stateVersion = "25.11";
      };
    };
  };
}
