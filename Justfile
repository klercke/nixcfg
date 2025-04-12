# List all just commands if none is supplied
default:
  @just --list

# Deploy flake
[linux]
[group('desktop')]
deploy:
  git add .
  nixos-rebuild switch --use-remote-sudo --flake $".#$(hostname)"
  exec zsh
