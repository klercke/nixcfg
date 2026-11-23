{
  flake.modules.homeManager.freyr-hyprland = {
    wayland.windowManager.hyprland.settings = {
      monitor = ",1920x1080@60,auto,1";

      input = {
        kb_layout = "us";
        kb_variant = "colemak";
      };
    };
  };
}
