{ config, pkgs, lib, ... }:

{
    xdg.portal.enable = false; # don't touch portals

    xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
      [preferred]
      default=hyprland
      org.freedesktop.impl.portal.Screenshot=hyprland
      org.freedesktop.impl.portal.ScreenCast=hyprland
    '';
}
