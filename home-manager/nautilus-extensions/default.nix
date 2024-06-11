{ config, pkgs, ... }:
{
  home.file."${config.xdg.dataHome}/nautilus-python/extensions/nautilus-kitty.py".source = ./nautilus-kitty.py;
}
