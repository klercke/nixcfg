{ inputs, ... }:
{
  flake.modules.nixos.noctalia-greeter = {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
      inputs.umbriel.nixosModules.default
    ];

    # Package (from the umbriel flake input), session file, systemd user unit,
    # and xdg-desktop-portal-umbriel all come from the upstream module.
    # Umbriel wraps its own Xwayland, so xwayland-satellite is no longer needed.
    programs.umbriel.enable = true;

    services.displayManager.noctalia-greeter = {
      enable = true;

      settings = {
        session.default = "Hyprland";
        appearance.hide_logo = true;
      };
    };
  };
}
