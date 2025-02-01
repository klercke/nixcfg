{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    hyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
