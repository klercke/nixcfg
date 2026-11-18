{
  flake.modules.homeManager.d0c-email = {
    accounts.email.accounts = {
      klercke = {
        primary = true;
        flavor = "migadu.com";
        address = "konnor@klercke.com";
        userName = "konnor@klercke.com";
        realName = "Konnor Klercke";
        gpg = {
          key = "06788C66C871D5627E714F9A6D08129B14785597";
          signByDefault = true;
        };
        signature = {
          showSignature = "append";
          text = ''
            Konnor Klercke
            klercke.com | keyoxide.org/6D08129B14785597
          '';
        };
        thunderbird.enable = true;
      };

      z3r0d4y = {
        flavor = "migadu.com";
        address = "d0c@z3r0d4y.dev";
        userName = "d0c@z3r0d4y.dev";
        realName = "d0c_z3r0d4y";
        gpg = {
          key = "06788C66C871D5627E714F9A6D08129B14785597";
          signByDefault = true;
        };
        signature = {
          showSignature = "append";
          text = ''
            d0c_z3r0d4y | Konnor Klercke
            klercke.com | keyoxide.org/6D08129B14785597
          '';
        };
        thunderbird.enable = true;
      };
    };
  };
}
