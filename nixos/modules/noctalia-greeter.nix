{ inputs, ... }: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
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
}
