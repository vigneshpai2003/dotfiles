{ pkgs, config, username, inputs, ... }:
{
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.displayManager.gdm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # - make nautilus extensions work
  environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    wofi
    waybar
    hyprpaper
    dunst
    libnotify

    # - gtk theming
    gnome.adwaita-icon-theme
    gnome.dconf-editor
    gsettings-desktop-schemas
    glib

    # - qt6 theming
    kdePackages.qt6ct

    # - nautilus
    gnome.nautilus
    gnome.nautilus-python

    # - to be started by hyprland
    polkit_gnome

    (pkgs.writeShellScriptBin "polkit-gnome" ''
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    '')

    mypkgs.waybar-mediaplayer
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # - gnome virtual file system, for trash support and evince history etc.
  services.gvfs.enable = true;

  # - configure gtk themes
  programs.dconf.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # - for electron/chromium apps to run wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
