{ config, pkgs, pkgs-unstable-new, ... }:
{
  imports = [
    ../external/etcher
    # ../external/warp
  ];

  home.packages = with pkgs; [
    brave

    # - office tools
    libsForQt5.okular # pdf
    libreoffice # office
    marktext # markdown
    obsidian # markdown note taking

    # - pictures
    loupe # viewer
    pinta # general purpose editor
    inkscape # vector graphics editor

    # - audio video
    pavucontrol # pulse audio volume control
    mpv # light media player
    vlc # general purpose media player
    # spotify # install using flatpak instead (weird titlebar in nixpkgs)

    # - others
    riseup-vpn
    libsForQt5.kdeconnect-kde # wireless connection to other devices
    geogebra6 # math graphing
    telegram-desktop
    oh-my-posh
    geekbench
  ] ++ (with pkgs-unstable-new; [
    warp-terminal
  ]);
}
