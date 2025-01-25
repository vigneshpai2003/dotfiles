{ packages, username, ... }:
let
  waitTime = 3;
in
{
  # - System service that calls a user service before suspend
  systemd.services.mysuspend = {
    before = [ "systemd-suspend.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''systemctl --user -M ${username}@ start --wait mycleanup.service'';
      ExecStartPost = ''/run/current-system/sw/bin/sleep ${builtins.toString waitTime}'';
    };
    wantedBy = [ "suspend.target" ];
  };

  home-manager.users.${username}.imports = [
    {
      # - User service that kills hotspots
      systemd.user.services.mycleanup = {
        Service = {
          Type = "oneshot";
          ExecStart = ''${packages.bash}/bin/bash -c "sudo create_ap --stop $(sudo create_ap --list-running | awk '{printf $1}')"'';
        };
      };
    }
  ];
}
