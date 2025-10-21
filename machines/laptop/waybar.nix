{ config, pkgs, lib, ... }:

let
  cfg = import ./config.nix;
in
{
  programs.waybar = {
    style = ''
      ${builtins.readFile ../../modules/waybar/style.css}
      ${builtins.readFile ./waybar-style.css}
    '';

    settings.mainBar = {
      modules-right = [
        "custom/media"
        "clock#date"
        "custom/updates"
        "tray"
        "pulseaudio"
        "cpu"
        "memory"
        "battery"
      ];

      pulseaudio = {
        format = "{volume}%";
        format-muted = "[MUTED] {volume}%";
      };

      "hyprland/workspaces".persistent-workspaces = {
        ${cfg.monitors.primary} = [
          "home"
          "firefox"
          "dev"
          "game"
          "scratchpad"
        ];
      };

      battery = {
        interval = 60;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        max-length = 25;
      };
    };
  };
}
