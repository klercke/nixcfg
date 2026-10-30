{
  flake.modules.homeManager.pyroclear =
    { pkgs, ... }:
    let
      tomlFormat = pkgs.formats.toml { };
    in
    {
      home.packages = [ pkgs.pyroclear ];

      xdg.configFile."pyroclear/config.toml".source = tomlFormat.generate "pyroclear-config.toml" {
        color.palette = "fire";
        animation = {
          fps = 120;
          wind = 0;
          height = 2;
          direction = 0;
          duration = 1;
          flames_duration = 0.38;
        };
      };

      home.shellAliases.clear = "pyroclear";
    };
}
