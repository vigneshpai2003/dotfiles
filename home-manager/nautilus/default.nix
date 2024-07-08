{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nautilus
    nautilus-python
  ];

  # - the actual extension
  home.file."${config.xdg.dataHome}/nautilus-python/extensions/nautilus-kitty.py".source = ./nautilus-kitty.py;
}
