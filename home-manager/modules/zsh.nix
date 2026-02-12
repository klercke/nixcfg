{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    completionInit = "autoload -U compinit && compinit";
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
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };

    shellAliases = {
      lg = "lazygit";
      cat = "bat";
      find = "fd";
      tf = "tofu";
      man = "batman";
    };

    initContent = let 
      zshConfigEarlyInit = lib.mkOrder 500 "zmodload zsh/zprof";
      zshConfigLateInit = lib.mkOrder 1500 "zprof";
      zshConfigInit = ''
        command -v fastfetch >/dev/null && fastfetch
        eval "$(${pkgs.zoxide}/bin/zoxide init zsh --cmd cd)" # this shouldn't be necessary 
      '';
    in
      lib.mkMerge [ zshConfigEarlyInit zshConfigInit zshConfigLateInit ];

  };
}
