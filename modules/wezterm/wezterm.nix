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
      sha256 = "sha256-xAEuaWM0WXf0majKdnp5N8PSKMkBF1rDg5i7kOlwQ38=";
    };
    "wezterm/shell-integration".source = ./shell-integration;
  };
}
