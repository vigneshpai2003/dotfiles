{ config, pkgs, ... }:
{
  # these files are stored at /etc/profiles/per-user/vignesh/share/applications/
  xdg.desktopEntries = {
    balenaEtcher = {
      name = "Balena Etcher";
      genericName = "USB";
      exec = ''appimage-run ${config.home.homeDirectory}/Apps/bin/balenaEtcher-1.18.11-x64.AppImage'';
      terminal = false;
      icon = "${config.home.homeDirectory}/Apps/icons/Etcher.png";
    };
    
    # hide KDE Connect entries
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
    
    # fix VS Code entries
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
