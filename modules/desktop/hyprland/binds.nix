{
  flake.modules.homeManager.hyprland-binds = {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod_SHIFT, Q, killactive"
        "$mainMod_SHIFT, M, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, D, exec, $noctalia panel-toggle launcher"
        "$mainMod, S, exec, $noctalia panel-toggle control-center"
        "$mainMod_SHIFT, V, exec, $noctalia panel-toggle clipboard"
        "$mainMod, comma, exec, $noctalia settings-toggle"
        "ALT, Tab, exec, $noctalia window-switcher hold"
        "$mainMod_SHIFT, L, exec, $noctalia session lock"
        "$mainMod, F, fullscreen"
        "$mainMod_SHIFT, S, exec, $noctalia screenshot-region"

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
        ", XF86AudioRaiseVolume, exec, $noctalia volume-up"
        ", XF86AudioLowerVolume, exec, $noctalia volume-down"
        ", XF86AudioMute, exec, $noctalia volume-mute"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, $noctalia brightness-up"
        ", XF86MonBrightnessDown, exec, $noctalia brightness-down"
      ];

      bindl = [
        ", XF86AudioNext, exec, $noctalia media next"
        ", XF86AudioPause, exec, $noctalia media toggle"
        ", XF86AudioPlay, exec, $noctalia media toggle"
        ", XF86AudioPrev, exec, $noctalia media previous"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
