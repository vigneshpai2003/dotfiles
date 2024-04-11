{ config, pkgs, username, ... }:
let
  caaDir = "/home/${username}/dotfiles/external/caa";
in
{
  networking.networkmanager = {
    dispatcherScripts = [{
      source = pkgs.writeText "IISERlogin" ''
        #!/usr/bin/env ${pkgs.bash}/bin/bash

        if [[ "$2" == "up" ]]; then
          export HOME=${caaDir}
          ${caaDir}/caa -d --log=${caaDir}/caa.log
          logger "Started IISER login daemon"
        fi

        if [[ "$2" == "down" ]]; then
          export HOME=${caaDir}
          ${caaDir}/caa -s
          logger "Stopped IISER login daemon"
        fi
      '';
      type = "basic";
    }];
  };
}
