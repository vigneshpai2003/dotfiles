{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome.nautilus
    gnome.nautilus-python # for python extensions
  ];

  home.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.gnome.nautilus}/lib/nautilus/extensions-4";

  # the actual extension
  home.file."${config.xdg.dataHome}/nautilus-python/extensions/nautilus-kitty.py".source = ./nautilus-kitty.py;
}
