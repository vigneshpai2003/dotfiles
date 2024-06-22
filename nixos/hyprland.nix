{ pkgs, config, inputs, username, ... }:
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

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  # - to be handled by hyprland
  services.logind = {
    powerKey = "ignore";
  };

  systemd.services.mysuspend = {
    enable = true;
    before = ["systemd-suspend.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''systemctl --user -M ${username}@ start --wait mylock.service'';
      ExecStartPost = ''/run/current-system/sw/bin/sleep 3'';
    };
    wantedBy = ["suspend.target"];
  };

  # - security
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  
  environment.systemPackages = with pkgs; [
    # - to be started by hyprland
    polkit_gnome
    (pkgs.writeShellScriptBin "polkit-gnome" ''
      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
    '')
  ];
}
