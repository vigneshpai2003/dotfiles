{ pkgs, inputs, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
  ];

  # - Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "source = ~/dotfiles/.config/hypr/hyprland.conf";
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [ ];
  };

  # - Hyprlock configuration
  programs.hyprlock = {
    enable = true;
    extraConfig = "source = ~/dotfiles/.config/hypr/hyprlock.conf";
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
