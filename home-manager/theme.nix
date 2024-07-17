{ pkgs, config, ... }:
let
  theme = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };

  cursorTheme = {
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
  };

  iconTheme = {
    name = "kora";
    package = pkgs.kora-icon-theme;
  };
in
{
  home = {
    packages = with pkgs;[
      dconf-editor # - GTK Settings
      kdePackages.qt6ct # - Qt6 Theming
      libsForQt5.qt5ct # - Qt5 Theming
      kdePackages.qtstyleplugin-kvantum # - Qt6 Theming
      libsForQt5.qtstyleplugin-kvantum # - Qt5 Theming

      theme.package
      cursorTheme.package
      iconTheme.package
    ];

    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
    };
  };

  gtk = {
    inherit cursorTheme iconTheme;
    theme.name = theme.name;
    enable = true;
  };
}
