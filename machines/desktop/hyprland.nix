{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # don't used patched waybar
    "$bar" = "waybar"; # "/home/sky/dev/waybar-fix/build/waybar";
  };
}
