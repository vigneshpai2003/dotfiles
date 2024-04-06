{ config, pkgs, ... }:
{
  imports = [ ../../external/caa ];

  networking.hostName = "vignesh-inspiron";
  networking.networkmanager.enable = true;
  programs.kdeconnect.enable = true; # connect to other devices over WiFi
}
