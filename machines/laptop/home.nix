{ config, pkgs, lib, ... }:

{
  imports = [
    ./monitors.nix
    ./hyprland.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
  ];
}
