{ config, pkgs, lib, ... }:

{
  imports = [
    ./monitors.nix
    ./nvidia.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
  ];
}
