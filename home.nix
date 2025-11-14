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
    ./modules/wofi/wofi.nix
    ./modules/neovim/neovim.nix
    ./modules/wezterm/wezterm.nix
    ./modules/zsh.nix
  ];

  # don't actually install anything
  home.packages = lib.mkForce [ ];
  home.extraOutputsToInstall = lib.mkForce [ ];
}
