{
  nix = {
    optimise = {
      automatic = true;
      dates = [ "02:15" ];
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
