{ config, pkgs, lib, ... }:

{
  programs.wezterm = {
    enable = true;
  };

  xdg.configFile = {
    "wezterm/wezterm.lua".source = ./wezterm.lua;
    "wezterm/bar.wezterm".source = ./bar.wezterm;
    "wezterm/shell-integration".source = ./shell-integration;
  };
}
