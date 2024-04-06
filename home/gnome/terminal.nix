{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tilix # terminal
  ];
  
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "tilix";
      name = "Open Terminal";
    };

    # tilix settings
    "com/gexperts/Tilix" = {
      app-title = "\${sessionName}";
      terminal-title-style = "small";
      use-tabs = true;
      warn-vte-config-issue = false;
    };
  };
}
