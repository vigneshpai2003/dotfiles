{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "source = ~/dotfiles/.config/hypr/hyprland.conf";
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

  home.packages = with pkgs; [
    hyprpaper
  ];
}
