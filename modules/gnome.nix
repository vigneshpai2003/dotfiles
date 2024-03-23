{ pkgs, config, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # for electron/chromium apps to run wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour ];

  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
