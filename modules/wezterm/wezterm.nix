{ config, pkgs, lib, ... }:
let
  colors = config.theme.colors;
in
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile = {
    "wezterm/wezterm.lua".text = ''
      	  --inject scheme into config
      	  local active_scheme = "${colors.wezterm_scheme}"

      	  ${builtins.readFile ./wezterm.lua}
      	'';
    "wezterm/bar.wezterm".source = pkgs.fetchFromGitHub {
      owner = "labruzese";
      repo = "bar.wezterm";
      rev = "main";
      sha256 = "sha256-xAEuaWM0WXf0majKdnp5N8PSKMkBF1rDg5i7kOlwQ38=";
    };
  };
}
