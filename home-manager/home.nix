{ homeStateVersion, user, ... }:
let
  userModules = [
    ./${user}.nix
    ./modules/${user}.nix
  ];
in
{
  imports = [
    ./home-packages.nix
    ./modules
  ]
  ++ userModules;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };
}
