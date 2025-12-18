{ config, pkgs, ... }:
let colors = config.theme.colors;
in {
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

  xdg.configFile."wofi/style.css".text = ''
    window {
    	margin: 10px;
    	border: 0px solid;
    	background: transparent;
    	font-family: JetbrainsMono;
    	font-size: 14px;
    }

    #input {
    	margin: 0px;
    	margin-left: 5px;
    	border: none;
    	color: ${colors.base07};
    	background-color: transparent;
    	border-radius: 0px;
    	padding: 0px;
    	font-size: 14px;
    	outline: none;
    }

    #input:focus {
    	outline: none;
    	box-shadow: none;
    }

    #inner-box {
    	margin: 0px;
    	padding: 8px;
    	border: none;
    	background-color: ${colors.base00};
    }

    #outer-box {
    	margin: 6px;
    	margin-left: 10px;
    	margin-right: 10px;
    }

    #text {
    	margin: 5px;
    	border: none;
    	color: ${colors.base07};
    	font-weight: 500;
    }

    #entry {
    	font-size: 14px;
    	background-color: transparent;
    	border: none;
    	border-radius: 8px;
    	margin: 0px 8px;
    	padding: 0px 12px;
    	transition: all 0.2s ease;
    }

    #entry:selected {
    	background-color: ${colors.base02};
    	border: 1px solid ${colors.base0D};
    }

    #entry:hover {
    	background-color: ${colors.base02};
    }

    #entry:selected #text {
    	color: ${colors.base0D};
    	font-weight: 600;
    }

    #img {
    	margin-right: 10px;
    	border-radius: 4px;
    }
  '';
  xdg.configFile."wofi/wezterm-wrapper" = {
    source = ./wezterm-wrapper;
    executable = true;
  };
}
