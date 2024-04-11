{ config, pkgs, ... }:
{
  networking.networkmanager.enable = true;
  programs.kdeconnect.enable = true;

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };
}
