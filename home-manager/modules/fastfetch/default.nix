{ lib, config, ... }: {
  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./fastfetch-config.jsonc);
  };

  programs = {
    bash.initExtra = lib.mkIf config.programs.bash.enable ''
      [[ $- == *i* ]] && fastfetch
    '';

    zsh.initContent = lib.mkIf config.programs.zsh.enable ''
      [[ -o interactive ]] && fastfetch
    '';

    fish.interactiveShellInit = lib.mkIf config.programs.fish.enable ''
      fastfetch
    '';
  };
}
