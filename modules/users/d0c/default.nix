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
        config.flake.modules.homeManager.d0c-email
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
            key = "06788C66C871D5627E714F9A6D08129B14785597";
          };
        };

        gpg.publicKeys = [
          {
            source = "${builtins.fetchurl {
              url = "https://klercke.com/pgp-key.txt";
              sha256 = "1867y3rhak0pnwvz90faw6aqa2ihysyagavbmkw7jmkhcmmwlm0v";
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
