{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    yaru-theme
    whitesur-gtk-theme
    whitesur-icon-theme
    gruvbox-plus-icons
    vimix-icon-theme
    tela-icon-theme
    rose-pine-icon-theme
    reversal-icon-theme
    pop-icon-theme
    papirus-icon-theme
    paper-icon-theme
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Yaru";
      gtk-theme = "Yaru-dark";
      icon-theme = "WhiteSur-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Yaru-dark";
    };

    "org/gnome/desktop/sound" = {
      theme-name = "Yaru";
    };
  };
}
