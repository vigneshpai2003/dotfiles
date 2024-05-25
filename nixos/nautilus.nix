{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    gnome.nautilus
    gnome.nautilus-python
  ];

  services.xserver.desktopManager.gnome.extraGSettingsOverridePackages = with pkgs; [
    nautilus-open-any-terminal
  ];

  environment.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${config.system.path}/lib/nautilus/extensions-4";

  # place nautilus python extensions in this directory
  environment.pathsToLink = [
    "/share/nautilus-python/extensions"
  ];
}
