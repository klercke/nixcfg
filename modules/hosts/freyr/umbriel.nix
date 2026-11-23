{
  flake.modules.homeManager.freyr-umbriel = {
    programs.umbriel.settings.input.keyboard = {
      layout = "us";
      variant = "colemak";
    };
  };
}
