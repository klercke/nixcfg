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

    shellAliases = {
      lg = "lazygit";
      cat = "bat";
      find = "fd";
      tf = "tofu";
      man = "batman";
    };

    # Enable for zsh profiling
    zprof.enable = false;

    initContent =
      let
        zshConfigEarlyInit = lib.mkOrder 500 "";
        zshConfigLateInit = lib.mkOrder 1500 "";
        zshConfigInit = lib.mkOrder 1000 ''
          command -v fastfetch >/dev/null && fastfetch --logo-color-1 "#cc241d" --logo-color-2 "#fe8019" --logo-color-3 "#d79921" --logo-color-4 "#98971a" --logo-color-5 "#458588" --logo-color-6 "#b16286"
          eval "$(${pkgs.zoxide}/bin/zoxide init zsh --cmd cd)" # this shouldn't be necessary 
        '';
      in
      lib.mkMerge [
        zshConfigEarlyInit
        zshConfigInit
        zshConfigLateInit
      ];

  };
}
