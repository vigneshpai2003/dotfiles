{ config, pkgs, ... }:
{
  home.file."${config.xdg.configHome}/hypr/hyprland.conf".text = "source = ~/dotfiles/.config/hypr/hyprland.conf";
}
