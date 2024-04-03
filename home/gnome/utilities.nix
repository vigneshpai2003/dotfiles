{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.gnome-system-monitor
    resources
    gnome.seahorse # encryption keys and passwords
    tilix
    gnome.nautilus # files
    gnome.gnome-disk-utility
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome.baobab # disk usage
    gnome.evince # pdf
    gnome-text-editor
    gnome-firmware # firmware updater
    gnome.gnome-characters
    gnome.gnome-font-viewer
    gnome.gnome-logs
    gnome.gnome-power-manager

    yaru-theme
    # whitesur-gtk-theme
  ];
}
