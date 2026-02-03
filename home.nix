{ config, pkgs, lib, theme ? "catppuccin-mocha", ... }: {
  home.username = "sky";
  home.homeDirectory = "/home/sky";
  home.stateVersion = "25.11";

  targets.genericLinux.enable = true;

  programs.home-manager.enable = true;

  imports = [
    ./modules/theme.nix
    ./modules/hyprland/hyprland.nix
    ./modules/xdg-portal.nix
    ./modules/waybar/waybar.nix
    ./modules/wofi/wofi.nix
    ./modules/neovim/neovim.nix
    ./modules/wezterm/wezterm.nix
    ./modules/zsh.nix
    ./modules/eww/eww.nix
  ];

  # type = lib.types.enum [ "catppuccin-mocha" "gruvbox-dark-soft" ];
  theme.name = theme;

  # don't actually install anything
  home.packages = lib.mkForce [ ];
  home.extraOutputsToInstall = lib.mkForce [ ];
}
