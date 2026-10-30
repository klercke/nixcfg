{
  flake.modules.nixos.zsh =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;

      users.defaultUserShell = pkgs.zsh;
    };

  flake.modules.homeManager.zsh =
    { pkgs, lib, ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        completionInit = ''
          # Only initialise once per session
          if [[ -z $ZSH_COMPDUMP ]]; then
            # Directory where the dump will be kept
            export ZSH_COMPDUMP="${builtins.getEnv "XDG_CACHE_HOME"}/zsh/.zcompdump"
            # Enable the cache and tell Zsh where to store it
            zstyle ':completion:*' use-cache true
            zstyle ':completion:*' cache-path "${builtins.getEnv "XDG_CACHE_HOME"}/zsh"
            # Initialise completion, skipping the costly compaudit step
            autoload -Uz compinit && compinit -C
          fi
        '';

        defaultKeymap = "emacs";

        history = {
          size = 1000;
          save = 1000;
          append = true;
          share = true;
          findNoDups = true;
          ignoreAllDups = true;
          ignoreDups = true;
          ignoreSpace = true;
          saveNoDups = true;
        };

        zplug = {
          enable = true;
          plugins = [
            {
              name = "zsh-users/zsh-autosuggestions";
              tags = [ "defer:2" ];
            }
            {
              name = "zsh-users/zsh-completions";
              tags = [ "defer:2" ];
            }
            {
              name = "zsh-users/zsh-syntax-highlighting";
              tags = [ "defer:2" ];
            }
          ];
        };

        # Enable for zsh profiling
        zprof.enable = false;

        initContent =
          let
            zshConfigEarlyInit = lib.mkOrder 500 "";
            zshConfigLateInit = lib.mkOrder 1500 "";
            zshConfigInit = lib.mkOrder 1000 ''
              eval "$(${pkgs.zoxide}/bin/zoxide init zsh --cmd cd)" # this shouldn't be necessary 
            '';
          in
          lib.mkMerge [
            zshConfigEarlyInit
            zshConfigInit
            zshConfigLateInit
          ];
      };
    };
}
