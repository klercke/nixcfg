#!/bin/sh
cd ~/nixos
nixos-rebuild switch --flake . --use-remote-sudo
