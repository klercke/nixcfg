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
          key = "14DD826AC43B2370D1C3BA6A9A0AA323503343D2";
          signByDefault = true;
        };
        thunderbird.enable = true;
      };

      z3r0d4y = {
        flavor = "migadu.com";
        address = "d0c@z3r0d4y.dev";
        userName = "d0c@z3r0d4y.dev";
        realName = "d0c_z3r0d4y";
        gpg = {
          key = "14DD826AC43B2370D1C3BA6A9A0AA323503343D2";
          signByDefault = true;
        };
        thunderbird.enable = true;
      };
    };
  };
}
