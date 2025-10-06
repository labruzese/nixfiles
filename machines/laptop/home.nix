{ config, pkgs, lib, ... }:

{
  imports = [
    ./monitors.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
  ];
}
