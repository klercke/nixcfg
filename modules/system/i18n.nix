{
  flake.modules.nixos.i18n = {
    i18n.defaultLocale = "en_US.UTF-8";
    console = {
      useXkbConfig = true;
    };
  };
}
