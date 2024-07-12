{ config, pkgs, hostname, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
        7100 # - uxplay
        7000
        7001
        53317 # - localsend
      ];
      allowedUDPPorts = [
        7011 # - passthrough uxplay
        6001
        6000
        53317 # - localsend
      ];
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
      domain = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  services.blueman.enable = true;
}
