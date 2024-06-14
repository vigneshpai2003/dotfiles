{ config, pkgs, username, ... }:
let
  caaDir = "/home/${username}/dotfiles/caa";
in
{
  networking.networkmanager = {
    dispatcherScripts = [{
      source = pkgs.writeText "IISERlogin" ''
        #!/usr/bin/env ${pkgs.bash}/bin/bash
        sudo -u ${username} DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send 'Hello world!' 'This is an example notification.'

        if [[ "$2" == "up" ]]; then
          export HOME=${caaDir}
          ${caaDir}/caa -d --log=${caaDir}/caa.log
          ${pkgs.libnotify}/bin/notify-send "Started IISER login daemon"
        fi

        if [[ "$2" == "down" ]]; then
          export HOME=${caaDir}
          ${caaDir}/caa -s
          ${pkgs.libnotify}/bin/notify-send "Stopped IISER login daemon"
        fi
      '';
      type = "basic";
    }];
  };
}
