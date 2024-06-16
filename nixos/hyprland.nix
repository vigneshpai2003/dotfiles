{ pkgs, config, username, inputs, ... }:
{
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.displayManager.gdm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  # - gnome virtual file system, for trash support and evince history etc.
  services.gvfs.enable = true;

  # - configure gtk settings
  programs.dconf.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # - for electron/chromium apps to run wayland

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  services.logind.powerKey = "ignore";
  services.logind.lidSwitch = "ignore";

  environment.systemPackages = with pkgs; [
    # - launcher
    wofi

    # - bar
    waybar
    mypkgs.waybar-mediaplayer

    # - notifications
    libnotify
    dunst

    # - clipboard
    wl-clipboard
    cliphist

    # - screen capture
    grim
    slurp
    grimblast

    # - gtk theming
    gnome.adwaita-icon-theme
    gnome.dconf-editor
    gsettings-desktop-schemas
    glib

    # - qt6 theming
    kdePackages.qt6ct

    # - to be started by hyprland
    polkit_gnome
    (pkgs.writeShellScriptBin "polkit-gnome" ''
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    '')
  ];
}
