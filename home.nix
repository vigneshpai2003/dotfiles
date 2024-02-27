{ config, pkgs, ... }:
{
  home.username = "vignesh";
  home.homeDirectory = "/home/vignesh";

  home.packages = with pkgs; [
    # - development
    python311Packages.python
    python311Packages.pip
    libgcc
    gfortran
    texliveMedium

    # - text editors
    vscode
    marktext # markdown
    # obsidian # markdown note taking

    # - virtual machine and remote machine
    virt-manager
    gnome.gnome-boxes
    # distrobox # containerized linux
    # gnome-connections # connect to remote host
    # filezilla # sftp / ftp
    # bottles # wine

    # - audio video
    pavucontrol # pulse audio volume control
    mpv # light media player
    vlc # general purpose media player
    spotify

    # - pictures
    pinta # general purpose editor
    # inkscape # vector graphics editor
    gnome.cheese # webcam

    # - gnome
    gnome.gnome-tweaks
    gnome-extension-manager
    gnome.dconf-editor

    # - others
    libsForQt5.okular # pdf
    # libreoffice # office
    libsForQt5.kdeconnect-kde # wireless connection to other devices
    # geogebra # math graphing
    # telegram-desktop
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Vignesh Pai";
    userEmail = "vigneshpai2003@gmail.com";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      "btop" = "btop --utf-force";
    };
  };

  programs.htop = {
    enable = true;
    settings = {
      show_cpu_usage = 1;
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    };
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