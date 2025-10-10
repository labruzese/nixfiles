{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.wofi;
in
{
  options.programs.wofi = {
    enable = mkEnableOption "wofi launcher";

    package = mkOption {
      type = types.package;
      default = pkgs.wofi;
      description = "The wofi package to use";
    };

    settings = mkOption {
      type = types.attrs;
      default = { };
      description = "Wofi configuration options";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."wofi/config".text = generators.toKeyValue { } cfg.settings;

    xdg.configFile."wofi/style.css".source = ./style.css;

    xdg.configFile."wofi/powermenu-style.css".source = ./powermenu-style.css;

    xdg.configFile."wofi/wezterm-wrapper" = {
      source = ./wezterm-wrapper;
      executable = true;
    };

    programs.wofi.settings = {
      show = "drun";
      sort_order = "default";
      hide_scroll = true;
      no_actions = true;
      width = 440;
      height = 344;
      xoffset = 795;
      yoffset = -37;
      line_wrap = "word";
      term = "/home/sky/.config/wofi/wezterm-wrapper";
      allow_markup = true;
      always_parse_args = false;
      show_all = true;
      print_command = true;
      layer = "overlay";
      allow_images = true;
      gtk_dark = true;
      prompt = "";
      image_size = 20;
      display_generic = false;
      location = "center";
      key_expand = "Tab";
      insensitive = true;
      key_up = "Ctrl-k";
      key_down = "Ctrl-j";
      style = "/home/sky/.config/wofi/style.css";
    };
  };
}
