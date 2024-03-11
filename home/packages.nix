{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    yaru-theme

    # - system
    gnome.gnome-system-monitor
    resources
    gnome.seahorse # encryption keys and passwords
    gnome.gnome-terminal
    gnome.nautilus
    nautilus-open-any-terminal
    gnome.gnome-disk-utility
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome.baobab
    riseup-vpn

    # - development
    (python311Packages.python.withPackages(p: with p; [
      numpy
      scipy
      matplotlib
      jupyter
    ]))
    sage
    gfortran
    fortls
    texliveFull
    direnv

    # - text editors
    gnome-text-editor
    vscode
    marktext # markdown
    obsidian # markdown note taking

    # - virtual machine and remote machine
    virt-manager
    gnome.gnome-boxes
    podman
    distrobox # containerized linux
    gnome-connections # connect to remote host
    filezilla # sftp / ftp
    bottles # wine

    # - audio video
    pavucontrol # pulse audio volume control
    mpv # light media player
    vlc # general purpose media player
    # spotify # install using flatpak instead (weird titlebar in nixpkgs)
    ffmpeg

    # - pictures
    pinta # general purpose editor
    inkscape # vector graphics editor
    gnome.cheese # webcam

    # - gnome
    gnome.gnome-tweaks
    gnome-extension-manager
    gnome.dconf-editor
    dconf2nix
    # whitesur-gtk-theme
    
    # - others
    libsForQt5.okular # pdf
    gnome.evince # pdf
    libreoffice # office
    libsForQt5.kdeconnect-kde # wireless connection to other devices
    geogebra6 # math graphing
    telegram-desktop
  ];
}
