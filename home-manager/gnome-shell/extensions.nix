{ config, pkgs, ... }:
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

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      disabled-extensions = [
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "gsconnect@andyholmes.github.io"
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
      ];

      enabled-extensions = [
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "dash-to-dock@micxgx.gmail.com"
        "tiling-assistant@leleat-on-github"
        "AlphabeticalAppGrid@stuarthayhurst"
        "batterytime@typeof.pw"
        "blur-my-shell@aunetx"
        "livecaptions@sapples.net"
        "transparent-top-bar@zhanghai.me"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "search-light@icedman.github.com"
      ];
    };
  };
}
