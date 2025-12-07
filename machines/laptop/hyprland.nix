{ config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland.settings = {
    input = {
      accel_profile = "adaptive";
      force_no_accel = false;

      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.5;
        tap-to-click = true;
        disable_while_typing = true;
      };
    };

    general = {
      gaps_in = 1;
      gaps_out = 3;
    };

    bind = [
      "$mod SHIFT, Return, exec, wezterm ssh desktop"
    ];

    bindl = [
      ", switch:Lid Switch, exec, hyprlock"
    ];

    env = [
      "WLR_NO_HARDWARE_CURSORS,1"
    ];
  };
}
