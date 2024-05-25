{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tilix # terminal
  ];

  dconf.settings = {
    "com/gexperts/Tilix" = {
      app-title = "\${sessionName}";
      terminal-title-style = "small";
      use-tabs = true;
      warn-vte-config-issue = false;
    };

    "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      terminal = "tilix";
    };
  };
}
