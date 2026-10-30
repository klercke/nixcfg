{ inputs, ... }:
{
  flake.modules.homeManager.opencode =
    { config, lib, ... }:
    let
      repoFile = lib.removePrefix (toString inputs.self) (toString ./opencode.jsonc);
    in
    {
      # Write global AGENTS.md for personal preferences
      xdg.configFile."opencode/AGENTS.md".source = ./AGENTS.md;

      # Must be a symlink since OpenCode TUI can write to it
      xdg.configFile."opencode/opencode.jsonc".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixcfg${repoFile}";
    };
}
