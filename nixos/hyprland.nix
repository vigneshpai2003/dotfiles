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
    (pkgs.writeShellScriptBin "polkit-gnome" ''
      ...
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
      ...
    '')
  ];

  security.polkit.enable = true;

  # for electron/chromium apps to run wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
