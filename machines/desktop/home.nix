{ config, pkgs, lib, ... }:

{
  imports = [
    ./monitors.nix
    ./nvidia.nix
    ./hyprland.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
  ];
}
