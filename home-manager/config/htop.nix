{ config, pkgs, ... }:
{
  programs.htop = {
    enable = true;
    settings = {
      show_cpu_usage = 1;
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    };
  };

  xdg.desktopEntries.htop = {
    name = "htop";
    noDisplay = true;
  };
}
