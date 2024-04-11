{ config, pkgs, ... }:
{
  xdg.desktopEntries.btop = {
    name = "btop++";
    noDisplay = true;
  };
}
