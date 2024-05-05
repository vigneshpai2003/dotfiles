{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.gnome-system-monitor
    resources # better system monitor
    gnome.nautilus # files
    gnome.baobab # disk usage
    gnome.gnome-disk-utility # disk info
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome.evince # pdf
    gnome-text-editor
    gnome-firmware # firmware updater
    gnome.gnome-characters
    gnome.gnome-font-viewer
    gnome.gnome-logs
    gnome.gnome-power-manager
    snapshot # camera
    gnome.gnome-maps
    gnome.gnome-weather
  ];
}
