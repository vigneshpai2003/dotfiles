{ config, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      toggle-fullscreen = [ "F11" ];
      close = [ "<Shift><Super>q" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "tilix";
      name = "Open Terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Control><Alt>w";
      command = "warp-terminal";
      name = "Open Warp";
    };
  };
}
