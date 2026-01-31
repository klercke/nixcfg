{ pkgs, ... }: {
  programs.firefox = {
    enable = true;
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
          order = [ "ddg" "NixPkgs" "ProtonDB" "google" ];
          engines = {
            "NixPkgs" = {
              urls = [{
                template = "https://search.nixos.org/packages?query={searchTerms}";
              }];
              updateInterval = 24 * 60 * 60 * 1000; # Once per day
              icon = "https://nixos.org/favicon.ico";
              definedAliases = [ "@np" ];
            };
            "ProtonDB" = {
              urls = [{ template = "https://www.protondb.com/search?q={searchTerms}"; }];
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
}
