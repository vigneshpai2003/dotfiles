{ config, pkgs, ... }:
{
  networking.hostName = "vignesh-inspiron";
  programs.kdeconnect.enable = true; # connect to other devices over WiFi

  networking.networkmanager = {
    enable = true;
    dispatcherScripts = [ {
      source = pkgs.writeText "IISERlogin" ''
        #!/usr/bin/env ${pkgs.bash}/bin/bash

        if [[ "$2" == "up" ]]; then
          export HOME=/home/vignesh/
          /home/vignesh/Apps/bin/caa -d --log=/home/vignesh/Apps/logs/caa.log
          logger "Started IISER login daemon"
        fi

        if [[ "$2" == "down" ]]; then
          export HOME=/home/vignesh/
          /home/vignesh/Apps/bin/caa -s
          logger "Stopped IISER login daemon"
        fi
      '';
      type = "basic";
      }
    ];
  };
}