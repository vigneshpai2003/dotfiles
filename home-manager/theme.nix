{ pkgs, config, ... }:
{
  home.packages = with pkgs;[
    gnome.dconf-editor # - GTK Settings
    nwg-look # - GTK3 Settings
    kdePackages.qt6ct # - Qt6 Theming
    libsForQt5.qt5ct # - Qt5 Theming
    kdePackages.qtstyleplugin-kvantum # - Qt6 Theming
    libsForQt5.qtstyleplugin-kvantum # - Qt5 Theming

    gnome.adwaita-icon-theme
  ];
}
