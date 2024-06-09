{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    lm_sensors
    powertop
    powerstat
  ];

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";
  services.thermald.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
}
