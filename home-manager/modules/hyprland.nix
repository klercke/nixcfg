{ hostname, ... }: {
  imports = [
    ../../hosts/${hostname}/hyprland.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";

      bind = [
        "$mainMod, Return, exec, $terminal"
      ];
    };
  };
}
