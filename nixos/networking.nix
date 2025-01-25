{ hostname, packages, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
      domain = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    settings.General.Experimental = true;
  };

  programs.kdeconnect = {
    enable = true;
    package = packages.gnomeExtensions.gsconnect;
  };
}
