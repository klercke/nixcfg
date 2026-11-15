{
  flake.modules.homeManager.mime-apps = {
    xdg.configFile."mimeapps.list".force = true;

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/mailto" = [ "thunderbird-handler.desktop" ];
        "message/rfc822" = [ "thunderbird-handler.desktop" ];

        "text/html" = [ "firefox.desktop" ];
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "x-scheme-handler/about" = [ "firefox.desktop" ];
        "x-scheme-handler/unknown" = [ "firefox.desktop" ];

        "application/pdf" = [ "org.kde.okular.desktop" ];
      };
    };
  };
}
