{ inputs, ... }:
{
  flake.modules.nixos.noctalia-greeter = { pkgs, ... }: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    environment.systemPackages = [
      pkgs.unstable.umbriel
      pkgs.xwayland-satellite # required on PATH when general.xwayland = true
    ];

    services.displayManager.noctalia-greeter = {
      enable = true;

      settings = {
        session.default = "Hyprland";
        appearance.hide_logo = true;
      };
    };

    # Required because programs.umbriel doesn't exist yet
    services.displayManager.sessionPackages = [ pkgs.unstable.umbriel ];
    systemd.packages = [ pkgs.unstable.umbriel ];
    systemd.user.services.umbriel = {
      restartIfChanged = false;
      enableDefaultPath = false;
    };
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.unstable.xdg-desktop-portal-umbriel ];
      configPackages = [ pkgs.unstable.xdg-desktop-portal-umbriel ];
    };
  };
}
