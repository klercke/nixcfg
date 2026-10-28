{ inputs, pkgs-unstable, ... }: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  environment.systemPackages = [
    pkgs-unstable.umbriel
    pkgs-unstable.xwayland-satellite # required on PATH when general.xwayland = true
  ];

  # Has to be enabled here so the session can be seen
  programs.hyprland.enable = true;

  programs.noctalia-greeter = {
    enable = true;

    settings = {
      session.default = "Hyprland";
      appearance.hide_logo = true;
    };
  };

  # Required because programs.umbriel doesn't exist yet
  services.displayManager.sessionPackages = [ pkgs-unstable.umbriel ];
  systemd.packages = [ pkgs-unstable.umbriel ];
  systemd.user.services.umbriel = {
    restartIfChanged = false;
    enableDefaultPath = false;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs-unstable.xdg-desktop-portal-umbriel ];
    configPackages = [ pkgs-unstable.xdg-desktop-portal-umbriel ];
  };
}
