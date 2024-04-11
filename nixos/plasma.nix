{ pkgs, config, lib, ... }:
{
  # services.desktopManager.plasma6.enable = true;
  # services.desktopManager.plasma6.excludePackages = with pkgs.kdePackages; [
  #   # Hack? To make everything run on Wayland
  #   qtwayland
  #   # Needed to render SVG icons
  #   qtsvg

  #   # Frameworks with globally loadable bits
  #   frameworkintegration # provides Qt plugin
  #   kauth # provides helper service
  #   kcoreaddons # provides extra mime type info
  #   kded # provides helper service
  #   kfilemetadata # provides Qt plugins
  #   kguiaddons # provides geo URL handlers
  #   kiconthemes # provides Qt plugins
  #   kimageformats # provides Qt plugins
  #   kio # provides helper service + a bunch of other stuff
  #   kpackage # provides kpackagetool tool
  #   kservice # provides kbuildsycoca6 tool
  #   kwallet # provides helper service
  #   kwallet-pam # provides helper service
  #   kwalletmanager # provides KCMs and stuff
  #   plasma-activities # provides plasma-activities-cli tool
  #   solid # provides solid-hardware6 tool
  #   phonon-vlc # provides Phonon plugin

  #   # Core Plasma parts
  #   kwin
  #   pkgs.xwayland

  #   kscreen
  #   libkscreen

  #   kscreenlocker

  #   kactivitymanagerd
  #   kde-cli-tools
  #   kglobalacceld
  #   kwrited # wall message proxy, not to be confused with kwrite

  #   milou
  #   polkit-kde-agent-1

  #   plasma-desktop
  #   plasma-workspace

  #   # Crash handler
  #   drkonqi

  #   # Application integration
  #   libplasma # provides Kirigami platform theme
  #   plasma-integration # provides Qt platform theme
  #   kde-gtk-config

  #   # Artwork + themes
  #   breeze
  #   breeze-icons
  #   breeze-gtk
  #   ocean-sound-theme
  #   plasma-workspace-wallpapers
  #   pkgs.hicolor-icon-theme # fallback icons
  #   qqc2-breeze-style
  #   qqc2-desktop-style

  #   # misc Plasma extras
  #   kdeplasma-addons

  #   pkgs.xdg-user-dirs # recommended upstream

  #   # Plasma utilities
  #   kmenuedit

  #   kinfocenter
  #   plasma-systemmonitor
  #   ksystemstats
  #   libksysguard

  #   spectacle
  #   systemsettings
  #   kcmutils

  #   # Gear
  #   baloo
  #   dolphin
  #   dolphin-plugins
  #   ffmpegthumbs
  #   kdegraphics-thumbnailers
  #   kde-inotify-survey
  #   kio-admin
  #   kio-extras
  #   kio-fuse

  #   plasma-browser-integration
  #   konsole
  #   (lib.getBin qttools) # Expose qdbus in PATH

  #   ark
  #   elisa
  #   gwenview
  #   okular
  #   kate
  #   khelpcenter
  #   print-manager
  # ];
}
