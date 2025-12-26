{ config, pkgs, lib, ... }:

{
  imports = [
    ./monitors.nix
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
  ];
}
