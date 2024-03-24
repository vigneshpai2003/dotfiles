{ pkgs, config, ... }:
{
  services.fprintd = {
    enable = true;
    # package = pkgs-master.fprintd;
    # tod = {
    #   enable = true;
    #   driver = pkgs.libfprint-2-tod1-goodix;
    # };
  };

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
}
