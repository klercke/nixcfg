{ pkgs, user, ... }:
{
  programs = {
    zsh.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "seat"
        "gamemode"
        "dialout"
      ];
      packages = with pkgs; [
        tree
        nano
        vim
        git
        just
        dotter

        fzf
        ripgrep
        eza
        btop
        glow
        bat
        tldr
        delta
        lazygit
        dust
        procs
        ghostty
      ];
    };
  };
}
