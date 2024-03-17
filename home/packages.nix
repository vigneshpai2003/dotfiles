{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # - office tools
    libsForQt5.okular # pdf
    libreoffice # office
    marktext # markdown
    obsidian # markdown note taking
    
    # - pictures
    pinta # general purpose editor
    inkscape # vector graphics editor

    # - audio video
    pavucontrol # pulse audio volume control
    mpv # light media player
    vlc # general purpose media player
    # spotify # install using flatpak instead (weird titlebar in nixpkgs)
    ffmpeg

    # - others
    riseup-vpn
    libsForQt5.kdeconnect-kde # wireless connection to other devices
    geogebra6 # math graphing
    telegram-desktop
  ];
}