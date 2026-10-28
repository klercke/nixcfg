{ config, ... }: {
  # Write global AGENTS.md for personal preferences
  xdg.configFile."opencode/AGENTS.md".source = ./AGENTS.md;

  # Must be a symlink since OpenCode TUI can write to it
  xdg.configFile."opencode/opencode.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixcfg/home-manager/modules/opencode/opencode.jsonc";

}
