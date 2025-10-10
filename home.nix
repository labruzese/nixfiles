{ config, pkgs, lib, ... }:
{
  home.username = "sky";
  home.homeDirectory = "/home/sky";
  home.stateVersion = "25.11";

  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ./modules/hyprland/hyprland.nix
    ./modules/uwsm.nix
    ./modules/xdg-portal.nix
    ./modules/waybar/waybar.nix
  ];

  home.packages = lib.mkForce [ ];
}
