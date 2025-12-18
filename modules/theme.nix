{ lib, config, ... }:

let
  cfg = config.theme;
in
{
  options.theme = {
    name = lib.mkOption {
      type = lib.types.enum [ "catppuccin-mocha" "gruvbox-dark-soft" ];
      default = "catppuccin-mocha";
      description = "The active color scheme";
    };

    # Expose the colors so other modules can access them via config.theme.colors
    colors = lib.mkOption {
      type = lib.types.attrs;
      internal = true;
    };
  };

  config = {
    theme.colors =
      if cfg.name == "catppuccin-mocha" then {
        # Base16 mapping for Catppuccin Mocha
        base00 = "#1e1e2e"; # Base
        base01 = "#181825"; # Mantle
        base02 = "#313244"; # Surface0
        base03 = "#45475a"; # Surface1
        base04 = "#585b70"; # Surface2
        base05 = "#cdd6f4"; # Text
        base06 = "#f5e0dc"; # Rosewater
        base07 = "#b4befe"; # Lavender
        base08 = "#f38ba8"; # Red
        base09 = "#fab387"; # Peach
        base0A = "#f9e2af"; # Yellow
        base0B = "#a6e3a1"; # Green
        base0C = "#94e2d5"; # Teal
        base0D = "#89b4fa"; # Blue
        base0E = "#cba6f7"; # Mauve
        base0F = "#f2cdcd"; # Flamingo

        # Tool specific names
        wezterm_scheme = "Catppuccin Mocha";
        neovim_plugin = "catppuccin";
        neovim_cmd = "catppuccin";
      } else {
        # Base16 mapping for Gruvbox Dark Soft
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

        # Tool specific names
        wezterm_scheme = "Gruvbox dark, soft (base16)";
        neovim_plugin = "gruvbox";
        neovim_cmd = "gruvbox";
      };
  };
}
