{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # don't used patched waybar
    "$bar" = "waybar"; # "/home/sky/dev/waybar-fix/build/waybar";
    "$screenshot_dir" = "/data/screenshot-history";

    bind = [
      "$mainMod SHIFT, Return, exec, $terminal_overlay"
    ];
  };
}
