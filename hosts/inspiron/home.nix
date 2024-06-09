{ config, inputs, pkgs, ... }:
{
  imports = [
    ../../home-manager/config
    ../../home-manager/spicetify.nix

    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    # - Basic Utilities
    resources # better system monitor
    gnome.baobab # disk usage
    gnome.gnome-disk-utility
    gnome.evince # pdf

    # - Office Tools
    libreoffice
    stable.onlyoffice-bin_latest
    marktext
    obsidian
    pdfarranger
    wike

    # - Pictures
    loupe
    pinta
    inkscape

    # - Audio Video
    ffmpeg
    mpv
    vlc
    cava

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
    zoom-us

    # - Warp Terminal
    (import ../../external/warp/package.nix { inherit lib pkgs; })

    # - Build GTK Applications
    gnome-builder

    # - Mirror iPhone
    uxplay

    # - Language
    dialect
    livecaptions
  ];

  programs.ags = {
    enable = true;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

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
