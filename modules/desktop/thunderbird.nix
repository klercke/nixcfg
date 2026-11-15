{
  flake.modules.homeManager.thunderbird = {
    programs.thunderbird = {
      enable = true;
      profiles.default = {
        isDefault = true;
        withExternalGnupg = true;
        settings = {
          "mail.shell.checkDefaultClient" = false;
          "mailnews.start_page.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.enabled" = false;
        };
      };
    };
    xdg.desktopEntries.thunderbird-handler = {
      name = "Thunderbird";
      exec = "env -u MOZ_APP_DATA -u MOZ_SYSTEM_DIR -u MOZ_APP_LAUNCHER thunderbird %u";
      icon = "thunderbird";
      noDisplay = true;
      mimeType = [
        "x-scheme-handler/mailto"
        "message/rfc822"
      ];
    };
  };
}
