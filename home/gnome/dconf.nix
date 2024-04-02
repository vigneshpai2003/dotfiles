{ config, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/wm/keybindings" = {
      toggle-fullscreen = [ "F11" ];
      close = [ "<Super>q" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "gnome-terminal";
      name = "Open Terminal";
    };

    "org/gnome/desktop/app-folders".folder-children = [ ];

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      text-scaling-factor = 1.25;
      enable-hot-corners = false;
      clock-show-seconds = true;
      color-scheme = "prefer-dark";
      cursor-theme = "Yaru";
      gtk-theme = "Yaru-dark";
      icon-theme = "Yaru-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Yaru-dark";
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
      theme-name = "Yaru";
    };

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
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      transparency-mode = "DYNAMIC";

      customize-alphas = true;
      max-alpha = 0.8;
      min-alpha = 0.0;

      dash-max-icon-size = 64;
      dock-position = "BOTTOM";
      height-fraction = 0.9;

      isolate-locations = true;
      isolate-workspaces = true;
      running-indicator-style = "DOTS";
      click-action = "minimize";

      show-mounts = false;
      show-show-apps-button = false;
      show-trash = false;
    };

    # CPU
    "org/gnome/shell/extensions/runcat" = {
      idle-threshold = 10;
      displaying-items = "character-and-percentage";
    };

    # system monitering
    "org/gnome/shell/extensions/vitals" = {
      fixed-widths = false;
      hot-sensors = [ "_fan_dell_ddv_cpu fan_" "__temperature_max__" "_battery_rate_" "_memory_usage_" "_processor_frequency_" ];
      position-in-panel = 0;
      show-battery = true;
      use-higher-precision = true;
    };
  };
}
