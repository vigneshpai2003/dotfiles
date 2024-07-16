{ username, ... }:
let
  waitTime = 3;
in
{
  services.hypridle.enable = true;

  # - System service that calls a user service before suspend
  systemd.services.mysuspend = {
    enable = true;
    before = [ "systemd-suspend.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''systemctl --user -M ${username}@ start --wait mylock.service'';
      ExecStartPost = ''/run/current-system/sw/bin/sleep ${builtins.toString waitTime}'';
    };
    wantedBy = [ "suspend.target" ];
  };

  home-manager.users.${username}.imports = [
    {
      # - Start hypridle and manage configuration manually
      services.hypridle.enable = false;

      # - User service that locks the session
      systemd.user.services.mylock = {
        Service = {
          Type = "oneshot";
          ExecStart = "loginctl lock-session";
        };
      };
    }
  ];
}
