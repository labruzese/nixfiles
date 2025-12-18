{ lib, config, pkgs, ... }:

let
  cfg = config.theme;
  themeData = if cfg.name == "catppuccin-mocha" then {
    colors = {
      base00 = "#1e1e2e";
      base01 = "#181825";
      base02 = "#313244";
      base03 = "#45475a";
      base04 = "#585b70";
      base05 = "#cdd6f4";
      base06 = "#f5e0dc";
      base07 = "#b4befe";
      base08 = "#f38ba8";
      base09 = "#fab387";
      base0A = "#f9e2af";
      base0B = "#a6e3a1";
      base0C = "#94e2d5";
      base0D = "#89b4fa";
      base0E = "#cba6f7";
      base0F = "#f2cdcd";
      wezterm_scheme = "Catppuccin Mocha";
      neovim_plugin = "catppuccin";
      neovim_cmd = "catppuccin";
      vencord =
        "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-catppuccin-mocha.theme.css";
    };
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Mocha-Standard-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override { variant = "mocha"; };
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
  } else {
    colors = {
      base00 = "#32302f";
      base01 = "#3c3836";
      base02 = "#504945";
      base03 = "#665c54";
      base04 = "#bdae93";
      base05 = "#d5c4a1";
      base06 = "#ebdbb2";
      base07 = "#fbf1c7";
      base08 = "#fb4934";
      base09 = "#fe8019";
      base0A = "#fabd2f";
      base0B = "#b8bb26";
      base0C = "#8ec07c";
      base0D = "#83a598";
      base0E = "#d3869b";
      base0F = "#d65d0e";
      wezterm_scheme = "Gruvbox dark, soft (base16)";
      neovim_plugin = "gruvbox";
      neovim_cmd = "gruvbox";
      vencord =
        "https://raw.githubusercontent.com/refact0r/midnight-discord/refs/heads/master/themes/flavors/midnight-vencord.theme.css";
    };
    gtk = {
      enable = true;
      theme = {
        name = "gruvbox-dark";
        package = pkgs.gruvbox-dark-gtk;
      };
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
      };
    };
  };

in {
  options.theme = {
    name = lib.mkOption {
      type = lib.types.enum [ "catppuccin-mocha" "gruvbox-dark-soft" ];
      default = "catppuccin-mocha";
      description = "The active color scheme";
    };
    colors = lib.mkOption {
      type = lib.types.attrs;
      internal = true;
    };
  };
  config = {
    theme.colors = themeData.colors;
    gtk = themeData.gtk;
  };
}
