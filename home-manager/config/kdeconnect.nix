{ config, pkgs, ... }:
{
  xdg.desktopEntries = {
    "org.kde.kdeconnect.sms" = {
      name = "org.kde.kdeconnect.sms";
      noDisplay = true;
    };
    "org.kde.kdeconnect-settings" = {
      name = "org.kde.kdeconnect-settings";
      noDisplay = true;
    };
    "org.kde.kdeconnect.nonplasma" = {
      name = "org.kde.kdeconnect-settings";
      noDisplay = true;
    };
  };
}
