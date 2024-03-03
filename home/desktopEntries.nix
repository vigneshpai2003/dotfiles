{config, pkgs, ...}:
{
  # these files are stored at /etc/profiles/per-user/vignesh/share/applications/
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
    
    code-url-handler = {
      name = "Visual Studio Code";
      noDisplay = false;
      exec="code %F";
      icon="vscode";
    };
    code = {
      name = "Visual Studio Code";
      noDisplay = true;
    };
  };
}
