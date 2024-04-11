{ pkgs, config, lib, ... }:
{
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    (lib.getBin qttools) # Expose qdbus in PATH
    ark
    elisa
    gwenview
    okular
    kate
    khelpcenter
    print-manager
  ];
}
