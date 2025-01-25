{ packages, config, ... }:
{
  services.flatpak.enable = true;

  # Using bindfs to create FHS font & icon directory
  system.fsPackages = [ packages.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
      };
      aggregatedIcons = packages.buildEnv {
        name = "system-icons";
        paths = with packages; [
          bibata-cursors
          kora-icon-theme
        ];
        pathsToLink = [ "/share/icons" ];
      };
      aggregatedFonts = packages.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
      "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
    };

  fonts.fontDir.enable = true;
}
