{ config, pkgs, username, ... }:
let
  caaDir = "/home/${username}/dotfiles/caa";
in
{
  networking.networkmanager = {
    dispatcherScripts = [{
      source = pkgs.writeText "IISERlogin" ''
        #!/usr/bin/env ${pkgs.bash}/bin/bash

        if [[ "$2" == "up" ]]; then
          export HOME=${caaDir}
          ${caaDir}/caa -d --log=${caaDir}/caa.log
          notify-send "Started IISER login daemon"
        fi

        if [[ "$2" == "down" ]]; then
          export HOME=${caaDir}
          ${caaDir}/caa -s
          notify-send "Stopped IISER login daemon"
        fi
      '';
      type = "basic";
    }];
  };
}
