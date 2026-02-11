{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    wget
    nom
    nh
    socat
  ];
}
