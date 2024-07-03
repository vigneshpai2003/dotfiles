#!/bin/sh

if systemctl --user status xdg-desktop-portal-hyprland.service | grep "active (running)"; then
    systemd-cat -t "vignesh@xdg-desktop-portal" echo "xdg-desktop-portal-hyprland is active"
else
    systemd-cat -t "vignesh@xdg-desktop-portal" echo "xdg-desktop-portal-hyprland is inactive, starting it"
    systemctl --user start xdg-desktop-portal-hyprland.service
fi
