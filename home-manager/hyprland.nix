{ pkgs, inputs, username, dotdir, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  # - Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "source = ${dotdir}/.config/hypr/hyprland.conf";
  };

  # - Hyprlock configuration
  programs.hyprlock = {
    enable = true;
    extraConfig = "source = ${dotdir}/.config/hypr/hyprlock.conf";
  };

  programs.ags = {
    enable = true;
    configDir = null;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
