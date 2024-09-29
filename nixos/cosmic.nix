{ pkgs, inputs, ... }:
{
  imports = [
    inputs.cosmic.nixosModules.default
  ];

  services.desktopManager.cosmic.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-applets
    cosmic-applibrary
    cosmic-bg
    cosmic-edit
    cosmic-files
    cosmic-greeter
    cosmic-icons
    cosmic-launcher
    cosmic-notifications
    cosmic-osd
    cosmic-panel
    cosmic-randr
    cosmic-screenshot
    cosmic-session
    cosmic-settings
    cosmic-settings-daemon
    cosmic-term
    cosmic-workspaces-epoch
    pop-icon-theme
    pop-launcher
  ];
}
