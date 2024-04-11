{ config, pkgs, ... }:
let
  caa = "/home/vignesh/dotfiles/external/caa";
in
{
  networking.networkmanager = {
    dispatcherScripts = [{
      source = pkgs.writeText "IISERlogin" ''
        #!/usr/bin/env ${pkgs.bash}/bin/bash

        if [[ "$2" == "up" ]]; then
          export HOME=${caa}
          ${caa}/caa -d --log=${caa}/caa.log
          logger "Started IISER login daemon"
        fi

        if [[ "$2" == "down" ]]; then
          export HOME=${caa}
          ${caa}/caa -s
          logger "Stopped IISER login daemon"
        fi
      '';
      type = "basic";
    }];
  };
}
