{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # - extension apps
    gnome-tweaks
    gnome-extension-manager
  ] ++ (with pkgs.gnomeExtensions; [
    dash-to-dock
    gsconnect
    alphabetical-app-grid
    battery-time-2
    blur-my-shell
    transparent-top-bar
    user-themes
    tiling-assistant
    clipboard-indicator
    caffeine
    live-captions-assistant
    search-light
  ]);
}
