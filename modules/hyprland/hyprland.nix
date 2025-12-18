{ config, pkgs, lib, ... }:
let
  colors = config.theme.colors;
in
{
  # deploy scripts
  xdg.configFile."hypr/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };

  # config
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # Programs - can be overridden per-machine
      "$terminal" = lib.mkDefault "uwsm app -- wezterm";
      "$terminal_overlay" = "~/.config/hypr/scripts/wezterm-overlay.sh";
      "$power_menu" = "~/.config/hypr/scripts/powermenu.sh";
      "$fileManager" = "uwsm app -- dolphin.desktop";
      "$menu" = "pkill wofi || wofi --show drun";
      "$lock" = "hyprlock";
      "$wallpaper" = "hyprpaper";
      "$bar" = lib.mkDefault "waybar";
      "$notify" = "mako";
      "$browser" = "uwsm app -- zen.desktop";
      "$chat" = "uwsm app -- vesktop.desktop";
      "$bluetooth" = "blueman-applet";
      "$screenshot_dir" = lib.mkDefault "~/screenshot-history";

      # Game patterns
      "$games" = "class:(steam|heroic|Steam|Heroic|gamescope|lutris|Lutris|bottles|Bottles|legendary|rare)";
      "$game_titles" = "title:(.*\\.exe|.*Steam.*|.*Heroic.*|.*Proton.*|.*Wine.*|.*game.*|.*Game.*|.*Rocket.*League.*|.*Unreal.*Engine.*|.*Unity.*|.*Direct3D.*|.*Vulkan.*|.*OpenGL.*)";
      "$game_classes" = "class:(RocketLeague|rocketleague|steam_app_.*|lutris-.*|heroic-.*|.*\\.exe)";

      # Autostart
      exec-once = [
        "$bluetooth"
        "$bar"
        "$wallpaper"
        "$notify"
        "keyd-application-mapper -d"
        "wl-paste --watch cliphist store"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "XDG_SESSION_TYPE,wayland"
        "WEZTERM_DPI_SCALE,1.0"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "DESKTOP_SESSION,Hyprland"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      # General settings
      general = {
        gaps_in = lib.mkDefault 4;
        gaps_out = lib.mkDefault 10;
        border_size = lib.mkDefault 1;
        "col.active_border" = "rgba(${lib.removePrefix "#" colors.base0D}ee) rgba(${lib.removePrefix "#" colors.base0E}ee) 45deg";
        "col.inactive_border" = "rgba(${lib.removePrefix "#" colors.base03}aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decorations
      decoration = {
        rounding = 2;

        active_opacity = 1.0;
        inactive_opacity = 0.88;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = lib.mkDefault true;
          size = lib.mkDefault 3;
          passes = lib.mkDefault 5;
          vibrancy = lib.mkDefault 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = lib.mkDefault true;

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        middle_click_paste = false;
        force_default_wallpaper = 0;
        disable_hyprland_logo = false;
        vfr = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = lib.mkDefault 1;
        accel_profile = lib.mkDefault "flat";
        force_no_accel = lib.mkDefault true;
        sensitivity = lib.mkDefault 0;

        touchpad = {
          natural_scroll = lib.mkDefault false;
        };
      };

      # Main modifier
      "$mod" = "SUPER";

      # Keybindings
      bind = [
        # Programs
        "$mod, backslash, exec, $terminal_overlay"
        "$mod, Return, exec, $terminal"
        "$mod, D, exec, $browser"
        "$mod, space, exec, $menu"
        "$mod, P, exec, $power_menu"
        "$mod, period, exec, $lock"

        # Window management
        "$mod SHIFT, C, exec, kill -9 $(hyprctl activewindow -j | jq -r '.pid')"
        "$mod, C, killactive,"
        "$mod ALT, S, togglesplit,"
        "$mod, F, fullscreen,"
        "$mod SHIFT, F, togglefloating,"

        # Focus movement
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Window movement
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        # Workspaces
        "$mod, Q, workspace, 1"
        "$mod, W, workspace, 2"
        "$mod, E, workspace, 3"
        "$mod, R, workspace, 4"
        "$mod, X, workspace, 5"

        # Move window to workspaces
        "$mod SHIFT, Q, movetoworkspace, 1"
        "$mod SHIFT, W, movetoworkspace, 2"
        "$mod SHIFT, E, movetoworkspace, 3"
        "$mod SHIFT, R, movetoworkspace, 4"
        "$mod SHIFT, X, movetoworkspace, 5"

        # special workspace
        "$mod, Z, togglespecialworkspace"
        "$mod, Z, movetoworkspace, +0"
        "$mod, Z, togglespecialworkspace"
        "$mod, Z, movetoworkspace, special"
        "$mod, Z, togglespecialworkspace"
        "$mod, S, togglespecialworkspace"

        # Scroll workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # Screenshot
        "$mod SHIFT, S, exec, grimblast --notify copysave area $screenshot_dir/$(date +%Y-%m-%d_%H-%M-%S).png"

        # Screen recording
        "$mod, G, exec, gsr-ui-cli toggle-show"
        "$mod, F11, exec, gsr-ui-cli replay-save-1-min"
        "$mod, F12, exec, gsr-ui-cli replay-save-10-min"

        # clipboard history with wofi
        "$mod, V, exec, cliphist list | wofi --dmenu --matching=fuzzy | cliphist decode | wl-copy"
      ];

      # Audio/brightness binds
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, ~/scripts/toggle-mute-with-sound.sh"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Media controls
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Mouse binds
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrule = [
        # Treat games differently
        "immediate, $game_classes"
        "fullscreenstate 2 2, $game_classes"
        "noborder, $game_classes"
        "noshadow, $game_classes"
        "noblur, $game_classes"
        "norounding, $game_classes"
        "noanim, $game_classes"
        "workspace 4, $game_classes"
        "stayfocused, $game_classes"

        # Rocket League
        "immediate, class:^(steam_app_322170)$"
        "stayfocused, class:^(steam_app_322170)$"

        # Automove vesktop to music
        "workspace 5, class:^(vesktop)$"
        "workspace special, class:^(wezterm-overlay)$"

        # Default settings
        # Don't allow maximization and don't focus window popups from xwayland apps
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };

  # Hyprland dependencies (currently managed by pacman)
  home.packages = with pkgs; [
    # uwsm                # Wayland session manager
    # hyprpaper           # Wallpaper daemon
    # hyprlock            # Screen locker
    # grimblast           # Screenshot tool
    # cliphist            # Clipboard history
    # wl-clipboard        # Wayland clipboard utilities (wl-copy, wl-paste)
    # wofi                # Application launcher
    # playerctl           # Media player controls
    # brightnessctl       # Brightness control
    # jq                  # JSON query (needed for: kill -9 $(hyprctl activewindow -j | jq -r '.pid'))
    # gpu-screen-recorder # Screen recording (provides gsr-ui-cli)
    # pipewire            # Audio (provides wpctl)
    # keyd                # Keyboard remapping (provides keyd-application-mapper)
    # blueman             # Bluetooth manager
  ];
}
