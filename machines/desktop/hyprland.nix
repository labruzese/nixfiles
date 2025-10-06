{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # used a patched waybar
    "$bar" = "/home/sky/dev/waybar-fix/build/waybar";
  };
}
