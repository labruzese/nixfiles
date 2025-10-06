{ config, pkgs, lib, ... }:

{
  # Configure portals
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    # Managed by pacman:
    # extraPortals = with pkgs; [
    #   xdg-desktop-portal-hyprland
    #   xdg-desktop-portal-gtk  # Fallback for file pickers, etc.
    # ];
  };
}
