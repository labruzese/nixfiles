{ config, pkgs, ... }:
{
  home.username = "sky";
  home.homeDirectory = "/home/sky";
  home.stateVersion = "25.11";

  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ./modules/hyprland.nix
    ./modules/uwsm.nix
  ];
}
