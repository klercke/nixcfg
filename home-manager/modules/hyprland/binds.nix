{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mainMod, Return, exec, $terminal"
      "$mainMod_SHIFT, Q, killactive"
      "$mainMod_SHIFT, M, exit"
      "$mainMod, V, togglefloating"
      "$mainMod, D, exec, $menu"
      "$mainMod_SHIFT, L, exec, loginctl lock-session"

      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"

      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      "$mainMod_SHIFT, 1, movetoworkspace, 1"
      "$mainMod_SHIFT, 2, movetoworkspace, 2"
      "$mainMod_SHIFT, 3, movetoworkspace, 3"
      "$mainMod_SHIFT, 4, movetoworkspace, 4"
      "$mainMod_SHIFT, 5, movetoworkspace, 5"
      "$mainMod_SHIFT, 6, movetoworkspace, 6"
      "$mainMod_SHIFT, 7, movetoworkspace, 7"
      "$mainMod_SHIFT, 8, movetoworkspace, 8"
      "$mainMod_SHIFT, 9, movetoworkspace, 9"
      "$mainMod_SHIFT, 0, movetoworkspace, 10"
    ];

    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
