{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.gnome-system-monitor
    resources
    gnome.seahorse # encryption keys and passwords
    gnome.gnome-terminal
    gnome.nautilus # files
    nautilus-open-any-terminal
    gnome.gnome-disk-utility
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome.baobab # disk usage
    gnome.evince # pdf
    gnome-text-editor
    gnome.cheese # webcam
    gnome-firmware # firmware updater

    yaru-theme
    # whitesur-gtk-theme
  ];
}
