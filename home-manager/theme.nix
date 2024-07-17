{ pkgs, ... }:
let
  theme = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };

  cursorTheme = {
    name = "Bibata-Modern-Classic";
    size = 24;
    package = pkgs.bibata-cursors;
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

      adwaita-icon-theme # - Default/Fallback Icon Theme
      theme.package
      cursorTheme.package
      iconTheme.package
    ];

    pointerCursor = cursorTheme;

    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
    };
  };

  # - Hyprland session variables
  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_THEME,${cursorTheme.name}"
      "XCURSOR_SIZE,${builtins.toString cursorTheme.size}"
      "QT_QPA_PLATFORMTHEME,qt5ct"
    ];
  };
  
  gtk = {
    inherit cursorTheme iconTheme;
    theme.name = theme.name;
    enable = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      text-scaling-factor = 1.25;
    };
  };
}
