{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # - extension tools
    gnome.gnome-tweaks
    gnome-extension-manager
    gnome.dconf-editor
    dconf2nix
  ] ++ (with pkgs.gnomeExtensions; [
    dash-to-dock
    gsconnect
    runcat
    alphabetical-app-grid
    battery-time-2
    blur-my-shell
    vitals
    transparent-top-bar
    user-themes
    tiling-assistant
    clipboard-indicator
  ]);
}
