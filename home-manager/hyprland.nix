{ config, pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    extraConfig = "source = ~/dotfiles/.config/hypr/hyprland.conf";
  };

  services.hypridle = {
    enable = true;
    importantPrefixes = [
      "$"
      "source"
    ];
    settings = {
      "source" = "${config.home.homeDirectory}/dotfiles/.config/hypr/hypridle.conf";
    };
  };

  home.packages = with pkgs; [
    hyprpaper
  ];
}
