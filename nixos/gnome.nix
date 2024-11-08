{ pkgs, ... }:
{
  # - Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # - Extra packages and exclude packages
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];
  services.gnome.core-utilities.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-weather
    geary
    gnome-contacts
    simple-scan
    yelp
    epiphany
    gnome-software
    gnome-music
    totem
  ];

  # - gnome virtual file system, for trash support and evince history etc.
  services.gvfs.enable = true;

  # - configure gtk settings
  programs.dconf.enable = true;

  # - for electron/chromium apps to run wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
