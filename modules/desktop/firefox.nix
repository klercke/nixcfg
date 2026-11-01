{
  flake.modules.homeManager.firefox =
    { pkgs, config, ... }:
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
        };

        profiles = {
          default = {
            id = 0;
            name = "default";
            isDefault = true;
            #settings = {
            #  "browser.startup.homepage" = "https://z3r0d4y.dev";
            #  "browser.search.defaultenginename" = "DuckDuckGo";
            #  "browser.search.order.1" = "DuckDuckGo";
            #};
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

            extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              bitwarden
              darkreader
              sponsorblock
            ];

          };
        };
      };
    };
}
