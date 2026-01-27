{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, Return, exec, $terminal"
      "$mainMod_SHIFT, Q, killactive"
      "$mainMod_SHIFT, M, exit"
      "$mainMod, V, togglefloating"
      "$mainMod, D, exec, $menu"
      "$mainMod_SHIFT, L, exec, loginctl lock-session"
    ];
  };
}
