{ pkgs, inputs, ... }:
{
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.displayManager.gdm.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # - gnome virtual file system, for trash support and evince history etc.
  services.gvfs.enable = true;

  # - configure gtk settings
  programs.dconf.enable = true;

  # - for electron/chromium apps to run wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # - to be handled by hyprland
  services.logind = {
    powerKey = "ignore";
  };
}
