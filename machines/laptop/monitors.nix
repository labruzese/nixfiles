{ config, pkgs, lib, ... }:

let
  cfg = import ./config.nix;
in
{
  wayland.windowManager.hyprland.settings = {
    "$primary_monitor" = cfg.monitors.primary;
    "$secondary_monitor" = cfg.monitors.secondary;

    monitor = [
      "$primary_monitor,preferred,0x0,1"
      "$secondary_monitor,2560x1440@60,2560x-1050,1,transform,3"
    ];

    workspace = [
      "1, monitor:$primary_monitor, default:true"
      "2, monitor:$primary_monitor"
      "3, monitor:$primary_monitor"
      "4, monitor:$primary_monitor"
      "5, monitor:$secondary_monitor, default:true, on-created-empty: $chat"
    ];
  };
}
