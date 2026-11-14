{
  flake.modules.homeManager.firefox =
    { config, ... }:
    {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";

        policies = {
          PasswordManagerEnabled = false;
          OfferToSaveLogins = false;
          DisableFormHistory = true;
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableFirefoxAccounts = false;

          Preferences = {
            "signon.rememberSignons" = {
              Value = false;
              Status = "locked";
            };
            "signon.autofillForms" = {
              Value = false;
              Status = "locked";
            };
            "signon.generation.enabled" = {
              Value = false;
              Status = "locked";
            };
            "signon.firefoxRelay.feature" = {
              Value = "disabled";
              Status = "locked";
            };
            "signon.management.page.breach-alerts.enabled" = {
              Value = false;
              Status = "locked";
            };
            "extensions.formautofill.addresses.enabled" = {
              Value = false;
              Status = "locked";
            };
            "extensions.formautofill.creditCards.enabled" = {
              Value = false;
              Status = "locked";
            };
          };

          ExtensionSettings =
            let
              ext = slug: area: {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
                installation_mode = "force_installed";
                default_area = area;
              };
            in
            {
              "uBlock0@raymondhill.net" = ext "ublock-origin" "navbar";
              "{446900e4-71c2-419f-a6a7-df9c091e268b}" = ext "bitwarden-password-manager" "navbar";
              "addon@darkreader.org" = ext "darkreader" "navbar";
              "sponsorBlocker@ajay.app" = ext "sponsorblock" "menupanel";
              "{1018e4d6-728f-4b20-ad56-37578a4de76b}" = ext "flagfox" "menupanel";
              "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}" = ext "gruvbox-dark-theme" "menupanel";
              "jid1-MnnxcxisBPnSXQ@jetpack" = ext "privacy-badger17" "menupanel";
              "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = ext "localcdn-fork-of-decentraleyes" "menupanel";
            };

          Homepage = {
            URL = "about:home";
            StartPage = "previous-session";
            Locked = true;
          };

          FirefoxHome = {
            Search = true;
            TopSites = true;
            SponsoredTopSites = false;
            Highlights = false;
            Pocket = false;
            SponsoredPocket = false;
            Snippets = false;
            Locked = true;
          };
        };

        profiles = {
          default = {
            id = 0;
            name = "default";
            isDefault = true;

            settings = {
              "browser.search.defaultenginename" = "DuckDuckGo";
              "browser.search.order.1" = "DuckDuckGo";

              "browser.uiCustomization.state" = builtins.toJSON (
                builtins.fromJSON ''
                  {"placements":{"widget-overflow-fixed-list":[],"nav-bar":["sidebar-button","back-button","forward-button","stop-reload-button","customizableui-special-spring1","vertical-spacer","urlbar-container","customizableui-special-spring2","reset-pbm-toolbar-button","downloads-button","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","unified-extensions-button","alltabs-button","smartwindow-group-tabs-button","ai-window-toggle"],"toolbar-menubar":["menubar-items"],"TabsToolbar":[],"vertical-tabs":["tabbrowser-tabs"],"PersonalToolbar":["personal-bookmarks"],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"]},"seen":["reset-pbm-toolbar-button","smartwindow-group-tabs-button","ai-window-toggle","addon_darkreader_org-browser-action","screenshot-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","sponsorblocker_ajay_app-browser-action","ublock0_raymondhill_net-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"],"dirtyAreaCache":["unified-extensions-area","nav-bar","TabsToolbar","vertical-tabs"],"currentVersion":28,"newElementCount":7}
                ''
              );

              "extensions.activeThemeID" = "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}";
            };

            search = {
              force = true;
              default = "ddg";

              order = [
                "ddg"
                "NixPkgs"
                "ProtonDB"
                "google"
              ];

              engines = {
                "NixPkgs" = {
                  urls = [
                    {
                      template = "https://search.nixos.org/packages?query={searchTerms}";
                    }
                  ];
                  updateInterval = 24 * 60 * 60 * 1000; # Once per day
                  icon = "https://nixos.org/favicon.ico";
                  definedAliases = [ "@np" ];
                };

                "ProtonDB" = {
                  urls = [ { template = "https://www.protondb.com/search?q={searchTerms}"; } ];
                  icon = "https://www.protondb.com/favicon.ico";
                  updateInterval = 24 * 60 * 60 * 1000; # Once per day
                  definedAliases = [ "@pd" ];
                };
              };
            };
          };
        };
      };
    };
}
