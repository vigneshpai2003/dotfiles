{ config, inputs, pkgs, ... }:
{
  imports = [
    ../../home-manager/gnome
    ../../home-manager/config
  ];

  home.packages = with pkgs; [
    # - Software Store
    nix-software-center
    
    # - Office Tools
    libreoffice
    marktext
    obsidian
    pdfarranger

    # - Pictures
    loupe
    pinta
    inkscape

    # - Audio Video
    ffmpeg
    mpv
    vlc
    # spotify # install using flatpak or snap instead (weird titlebar in nixpkgs on gnome)

    # - Virtual Machines
    gnome.gnome-boxes

    # - Distrobox GUI
    boxbuddy

    # - Wine
    bottles

    # - Remote Connections
    gnome-connections
    filezilla

    # - VPN
    riseup-vpn

    # - KDE Connect GUI
    libsForQt5.kdeconnect-kde

    # - Math Graphing
    geogebra6

    # - Social
    telegram-desktop

    # - Warp Terminal
    (import ../../external/warp/package.nix {inherit lib pkgs;})

    # - Build GTK Applications
    stable.gnome-builder

    # - Burn ISO to USB
    stable.etcher
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
