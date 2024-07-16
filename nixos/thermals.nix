{ ... }:
{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  services = {
    thermald.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };
}
