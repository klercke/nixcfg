{
  imports = [
    ./zsh.nix
    ./zoxide.nix
    ./eza.nix
    ./hyprland
    ./ghostty.nix
    ./wofi
    ./stylix.nix
    ./waybar
    ./xdg-terminal-exec.nix
    ./btop.nix
    ./nixvim
    ./git.nix
    ./gpg.nix
    ./firefox.nix
    ./zellij.nix
    ./direnv.nix
    ./delta.nix
  ];

  programs.git = {
    settings = {
      user = {
        name = "Konnor Klercke";
        email = "klercke@protonmail.com";
      };
    };

    signing = {
      signByDefault = true;
      key = "9A0AA323503343D2";
    };
  };
}
