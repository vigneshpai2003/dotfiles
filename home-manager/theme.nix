{ packages, ... }:
let
  gtkTheme = {
    name = "adw-gtk3-dark";
    package = packages.adw-gtk3;
  };

  cursorTheme = {
    name = "Bibata-Modern-Classic";
    size = 24;
    package = packages.bibata-cursors;
  };

  iconTheme = {
    name = "kora";
    package = packages.kora-icon-theme;
  };
in
{
  home = {
    packages = with packages;[
      dconf-editor # - GTK Settings

      adwaita-icon-theme # - Default/Fallback Icon Theme
      gtkTheme.package
      cursorTheme.package
      iconTheme.package
    ];

    pointerCursor = cursorTheme;

    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
    };
  };
  
  gtk = {
    inherit cursorTheme iconTheme;
    theme.name = gtkTheme.name;
    enable = true;
  };
}
