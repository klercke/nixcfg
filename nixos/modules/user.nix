{ pkgs, user, ...}: {
  programs = {
    zsh.enable = true;
    starship.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      packages = with pkgs; [
        tree
        neovim
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
