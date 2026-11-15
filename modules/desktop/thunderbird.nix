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
  };
}
