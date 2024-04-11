{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    stable.yaru-theme
    # whitesur-gtk-theme
  ];
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Yaru";
      gtk-theme = "Yaru-dark";
      icon-theme = "Yaru-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Yaru-dark";
    };

    "org/gnome/desktop/sound" = {
      theme-name = "Yaru";
    };
  };
}
