{ pkgs, config, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    wofi
    waybar
    hyprpaper
    polkit_gnome
    dunst
    libnotify

    gnome.adwaita-icon-theme
    nwg-look
    kdePackages.qt6ct
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    gsettings-desktop-schemas
    gnome.dconf-editor
    glib
    (pkgs.writeShellScriptBin "polkit-gnome" ''
      ...
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      ...
    '')
  ];

  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # for electron/chromium apps to run wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
