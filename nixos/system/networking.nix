{ config, pkgs, hostname, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

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

  networking.firewall = {
    enable = true;
    # passthrough uxplay
    allowedTCPPorts = [ 7100 7000 7001 ]; 
    allowedUDPPorts = [ 7011 6001 6000 ];
  };

  programs.kdeconnect.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  services.blueman.enable = true;
}
