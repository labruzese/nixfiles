{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    
    settings = {
      show = "drun";
      sort_order = "default";
      hide_scroll = true;
      no_actions = true;
      width = 440;
      height = 344;
      xoffset = 795;
      yoffset = -37;
      line_wrap = "word";
      term = "~/.config/wofi/wezterm-wrapper";
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
      style = "~/.config/wofi/style.css";
    };
  };

  xdg.configFile."wofi/style.css".source = ./style.css;
  xdg.configFile."wofi/powermenu-style.css".source = ./powermenu.css;
  xdg.configFile."wofi/wezterm-wrapper" = {
    source = ./wezterm-wrapper;
    executable = true;
  };
}
