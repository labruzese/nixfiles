{ config, pkgs, lib, ... }:

{
  programs.wezterm = {
    enable = true;
  };

  xdg.configFile = {
    "wezterm/wezterm.lua".source = ./wezterm.lua;
    "wezterm/bar.wezterm".source = pkgs.fetchFromGitHub {
      owner = "labruzese";
      repo = "bar.wezterm";
      rev = "main";
      sha256 = lib.fakeSha256;
    };
    "wezterm/shell-integration".source = ./shell-integration;
  };
}
