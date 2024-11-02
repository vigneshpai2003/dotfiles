{ config, pkgs, ... }:
{
  dconf.settings = {
    # window buttons
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };
    
    # touchpad
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };

    # show no folders
    "org/gnome/desktop/app-folders".folder-children = [ "Placeholder" ];

    # workspaces
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    # isolate workspaces
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    # misc
    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
      text-scaling-factor = 1.25;
      enable-hot-corners = false;
      clock-show-seconds = true;
    };

    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };
  };
}
