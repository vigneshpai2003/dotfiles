{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.libinput.enable = true;

  # - Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # - Extra packages and exclude packages
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = with pkgs; [ gnome-tour ];
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # - gnome virtual file system, for trash support and evince history etc.
  services.gvfs.enable = true;

  # - configure gtk settings
  programs.dconf.enable = true;

  # - for electron/chromium apps to run wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
