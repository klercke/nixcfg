# List all just commands if none is supplied
default:
  @just --list

# Deploy flake
[linux]
[group('desktop')]
deploy:
  git add .
  nh os switch $".#nixosConfigurations.$(hostname)" --ask
  nh home switch .# --ask
  exec zsh

# Update flake
[linux]
[group('desktop')]
switch-update:
  git add .
  nh os switch $".#nixosConfigurations.$(hostname)" --ask --update
  nh home switch .# --ask --update
  exec zsh


commit:
  git add .
  git commit
