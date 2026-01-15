{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    nom
    dix
    gcc # Needed for lazyvim
    nodejs # Needed for lazyvim
    go # Needed for lazyvim
    unzip # Needed for lazyvim
    python3 # Needed for lazyvim
    statix # Needed for lazyvim
  ];
}
