{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  programs.kdeconnect.enable = true; # connect to other devices over WiFi

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };
}
