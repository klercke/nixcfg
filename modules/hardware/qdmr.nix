{
  flake.modules.nixos.qdmr = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.qdmr ];
    services.udev.packages = [ pkgs.qdmr ];
  };
}
