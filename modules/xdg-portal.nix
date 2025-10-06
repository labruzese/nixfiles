{ config, pkgs, lib, ... }:

{
  # Configure portals
  xdg.portal = {
    enable = true;
    config.preferred = {
      default = "hyprland";
      "org.freedesktop.impl.portal.Screenshot" = "hyprland";
      "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
    };
    # Managed by pacman:
    # extraPortals = with pkgs; [
    #   xdg-desktop-portal-hyprland
    #   xdg-desktop-portal-gtk  # Fallback for file pickers, etc.
    # ];
  };
}
