# `devshell <lang>` points direnv at one of nixcfg's portable shells for the
# current repo without leaving anything in that repo's tracked files.
{
  flake.modules.homeManager.devshell = {
    programs.zsh.initContent = ''
      devshell() {
        if [[ -z $1 ]]; then
          print -u2 "usage: devshell <go|iac|python|rust|web>"
          return 1
        fi
        local root exclude
        root=$(git rev-parse --show-toplevel 2>/dev/null) || {
          print -u2 "devshell: not inside a git repository"
          return 1
        }
        if [[ -e $root/.envrc ]]; then
          print -u2 "devshell: $root/.envrc already exists"
          return 1
        fi
        exclude=$(git -C "$root" rev-parse --path-format=absolute --git-path info/exclude)
        mkdir -p "''${exclude:h}"
        local entry
        for entry in .envrc .direnv; do
          grep -qxF "$entry" "$exclude" 2>/dev/null || print -r -- "$entry" >> "$exclude"
        done
        print -r -- "use flake $HOME/nixcfg#$1" > "$root/.envrc"
        direnv allow "$root"
      }
    '';
  };
}
