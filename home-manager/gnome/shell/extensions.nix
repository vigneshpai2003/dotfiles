{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # - extension apps
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
    caffeine
  ]);

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      disabled-extensions = [
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
      ];

      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "runcat@kolesnikov.se"
        "dash-to-dock@micxgx.gmail.com"
        "gsconnect@andyholmes.github.io"
        "AlphabeticalAppGrid@stuarthayhurst"
        "batterytime@typeof.pw"
        "blur-my-shell@aunetx"
        "Vitals@CoreCoding.com"
        "transparent-top-bar@zhanghai.me"
        "tiling-assistant@leleat-on-github"
        "clipboard-indicator@tudmotu.com"
        "caffeine@patapon.info"
      ];
    };
  };
}
