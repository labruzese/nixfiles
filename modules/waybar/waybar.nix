{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = lib.mkDefault "top";
        position = lib.mkDefault "top";
        mode = lib.mkDefault "dock";
        reload-style-on-change = lib.mkDefault true;

        modules-left = lib.mkDefault [
          "custom/launcher"
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = lib.mkDefault [
          "clock#time"
        ];

        modules-right = lib.mkDefault [
          "custom/media"
          "clock#date"
          "custom/updates"
          "tray"
          "pulseaudio"
          "cpu"
          "memory"
          # "custom/gpu"
        ];

        pulseaudio = {
          tooltip = lib.mkDefault false;
          format = lib.mkDefault "{format_source}";
          format-source = lib.mkDefault "         ";
          format-source-muted = lib.mkDefault " ";
          on-click = lib.mkDefault "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = " ";
            "2" = " ";
            "3" = " ";
            "4" = " ";
            "5" = " ";
            "special" = " ";
          };
          show-special = true;
          # special-visible-only = true;
          format-window-seperator = "";
          window-rewrite-default = "<span size='small'></span>";
          window-rewrite = {
            "class<vesktop>" = "<span size='small'></span>";
            "class<Spotify>" = "<span size='small'></span>";
            "class<rocketleague.exe>" = "<span size='small'></span>";
            "class<.*wezterm>" = "<span size='small'><i><b>$W</b></i></span>";
            "class<firefox>" = "<span size='small'></span>";
            "class<steam>" = "<span size='small'></span>";
          };
          on-click = "activate";
          persistent-workspaces = {
            DP-3 = [
              "1"
              "2"
              "3"
              "4"
            ];
          };
        };

        "hyprland/window" = {
          format = " {}";
          separate-outputs = true;
          max-length = 50;
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        "clock#time" = {
          tooltip = false;
          format = "{:%I:%M}";
        };

        "clock#date" = {
          tooltip = false;
          format = "{:%b %d}";
          # on-click = "~/.config/waybar/scripts/start-quickshell.sh ~/.config/waybar/quickshell/dashboard.qml"
        };

        cpu = {
          interval = 10;
          # format = " {avg_frequency}Ghz";
          format = "{usage}% cpu";
          format-icons = [
            "<span color='#a7ffd0'></span>"
            "<span color='#c9ffad'></span>"
            "<span color='#fff7c6'></span>"
            "<span color='#fff7c6'></span>"
            "<span color='#ffc3b5'></span>"
            "<span color='#f3a08d'></span>"
          ];
          # max-length = 10
        };

        "custom/gpu" = {
          exec = "~/.config/waybar/scripts/gpu.sh";
          interval = 15;
          format = "{}";
          tooltip = false;
        };

        memory = {
          interval = 30;
          format = "{percentage}% mem";
          max-length = 10;
        };

        "custom/media" = {
          format = "{icon} {text}";
          return-type = "json";
          max-length = 50;
          format-icons = {
            spotify = " ";
            spotify-paused = " ";
            default = "󰓃 ";
            paused = " ";
          };
          escape = true;
          exec = "~/.config/waybar/scripts/mediaplayer.py -vvv";
          on-click = "playerctl play-pause";
          on-click-right = "pkill -SIGUSR1 -f mediaplayer.py";
        };

        "custom/launcher" = {
          tooltip = false;
          format = " ";
          on-click = "pkill wofi || /home/sky/.config/hypr/scripts/powermenu.sh";
          on-click-right = "pkill wofi || wofi --show drun";
        };

        "custom/updates" = {
          format = "<b>{}</b>{icon}";
          return-type = "json";
          format-icons = {
            has-updates = "<big> 󱍷</big>";
            updated = "<big> </big>";
          };
          exec-if = "";
          exec = "waybar-module-pacman-updates --no-zero-output";
          on-click = "hyprctl dispatch exec '~/.config/hypr/scripts/wezterm-overlay.sh paru'";
        };
      };
    };

    style = lib.mkDefault (builtins.readFile ./style.css);
  };
}
