{
  flake.modules.nixos.colemak = {
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.variant = "colemak";
  };
}
