{ config, pkgs, hostname, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };
  
  programs.kdeconnect.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };
}
