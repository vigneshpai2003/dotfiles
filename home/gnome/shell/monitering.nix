{ config, pkgs, ... }:
{
  dconf.settings = {
    # CPU
    "org/gnome/shell/extensions/runcat" = {
      idle-threshold = 10;
      displaying-items = "character-and-percentage";
    };

    # system
    "org/gnome/shell/extensions/vitals" = {
      fixed-widths = false;
      hot-sensors = [ "_fan_dell_ddv_cpu fan_" "__temperature_max__" "_battery_rate_" "_memory_usage_" "_processor_frequency_" ];
      position-in-panel = 0;
      show-battery = true;
      use-higher-precision = true;
    };
  };
}
