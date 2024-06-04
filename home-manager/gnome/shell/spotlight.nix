{ config, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/shell/extensions/search-light" = {
      border-radius = 2.3;
      background-color = [0.0 0.0 0.0 0.5];
      shortcut-search = ["<Super>z"];
    };
  };
}