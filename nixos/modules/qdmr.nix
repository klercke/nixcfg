{ pkgs-unstable, ... }: {
  environment.systemPackages = [ pkgs-unstable.qdmr ];
  services.udev.packages = [ pkgs-unstable.qdmr ];
}
