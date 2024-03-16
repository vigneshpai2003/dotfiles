{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    lm_sensors
    powertop
    powerstat
  ];

  powerManagement.enable = true;
  services.thermald.enable = true;
}