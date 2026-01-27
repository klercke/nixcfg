{ hostname, ... }: {
  imports = [
    ./main.nix
    ../../../hosts/${hostname}/hyprland.nix
    ./binds.nix
  ];
}
