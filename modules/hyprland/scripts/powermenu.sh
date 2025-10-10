#!/bin/bash

if ! killall wofi 2>/dev/null; then
  :
fi

options="Lock\nSleep\nReboot\nShutdown\nLogout"

selected=$(echo -e "$options" | wofi --dmenu --style ~/.config/wofi/powermenu.css)

case $selected in
    "Lock")
        hyprlock 
        ;;
    "Sleep")
        systemctl suspend
        ;;
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
    "Logout")
        uwsm stop
        ;;
esac
