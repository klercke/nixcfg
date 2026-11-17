{
  flake.modules.homeManager.thor-umbriel = {
    programs.umbriel.settings.output = {
      # Portrait 1080p to the left, vertically centered against the ultrawide
      # (matches Hyprland's auto-center-left). Positions are logical, after transform.
      DP-2 = {
        transform = "90";
        position = [
          0
          0
        ];
      };

      # Without `mode` Umbriel uses the monitor's preferred mode, which may not be its
      # highest refresh rate. Run `umbriel outputs` in the session and pin it here,
      # e.g. mode = "3440x1440@<hz>";
      DP-1 = {
        position = [
          1080
          240
        ];
      };
    };
  };
}
