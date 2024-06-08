{ pkgs, config, ... }:
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wofi
    waybar
  ];

  # for electron/chromium apps to run wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
