{ config, pkgs, ... }:
{
  xdg.desktopEntries = {
    code-url-handler = {
      name = "Visual Studio Code";
      noDisplay = false;
      exec = "code %F";
      icon = "vscode";
    };
    code = {
      name = "Visual Studio Code";
      noDisplay = true;
    };
  };
}
