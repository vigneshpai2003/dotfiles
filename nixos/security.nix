{ pkgs, ... }:
{
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
