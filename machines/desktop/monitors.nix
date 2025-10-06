{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$primary_monitor" = "DP-3";
    "$secondary_monitor" = "DP-2";

    monitor = [
      "$primary_monitor,2560x1440@280,0x0,1"
      "$secondary_monitor,2560x1440@60,2560x-1050,1,transform,3"
    ];

    workspace = [
      "name:home, monitor:$primary_monitor, default:true"
      "name:firefox, monitor:$primary_monitor"
      "name:dev, monitor:$primary_monitor"
      "name:game, monitor:$primary_monitor"
      "name:scratchpad, monitor:$primary_monitor"

      "name:music, monitor:$secondary_monitor, default:true, on-created-empty: $chat"
      "name:firefox-ref, monitor:$secondary_monitor"
      "name:scratchpad2, monitor:$secondary_monitor"
    ];
  };
}
