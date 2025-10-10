{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        mode = "dock";
        reload-style-on-change = true;

        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock#time"
        ];

        modules-right = [
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
          tooltip = false;
          format = "{format_source}";
          format-source = "         ";
          format-source-muted = " ";
          on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            home = " ";
            firefox = " ";
            dev = " ";
            game = " ";
            scratchpad = " ";
            music = " ";
            firefox-ref = "*";
            scratchpad2 = " ";
          };
          format-window-seperator = "";
          window-rewrite-default = "<span size='small'></span>";
          window-rewrite = {
            "class<discord>" = "<span size='small'></span>";
            "class<Spotify>" = "<span size='small'></span>";
            "class<rocketleague.exe>" = "<span size='small'></span>";
            "class<.*wezterm>" = "<span size='small'><i><b>$W</b></i></span>";
            "class<firefox>" = "<span size='small'></span>";
            "class<steam>" = "<span size='small'></span>";
          };
          on-click = "activate";
          sort-by = "id";
          persistent-workspaces = {
            DP-3 = [
              "home"
              "firefox"
              "dev"
              "game"
              "scratchpad"
            ];
            DP-2 = [
              "music"
              "firefox-ref"
              "scratchpad2"
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
          interval = 15;
          # format = " {avg_frequency}Ghz";
          format = " {avg_frequency}";
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
          format = " {used}";
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

    style = builtins.readFile ./style.css;
  };
}
