{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };

      label = [
        {
          text = "cmd[update:1000] echo '$TIME'";
          font_size = 70;
          color = "rgba(ebdbb2ff)";
          position = "-50, 20";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
        {
          text = "$USER";
          color = "rgba(ebdbb2ff)";
          font_size = 20;
          position = "-50, 120";
          halign = "right";
          valign = "bottom";
          shadow_passes = 5;
          shadow_size = 10;
        }
      ];
    };
  };
}
