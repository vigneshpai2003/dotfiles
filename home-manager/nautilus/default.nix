{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nautilus
    nautilus-python
  ];

  # - the actual extension
  home.file."${config.xdg.dataHome}/nautilus-python/extensions/nautilus-kitty.py".source = ./nautilus-kitty.py;
  
  # - set environment variable in Hyprland
  wayland.windowManager.hyprland.settings.env = [
    "NAUTILUS_4_EXTENSION_DIR,/etc/profiles/per-user/vignesh/lib/nautilus/extensions-4"
  ];
}
