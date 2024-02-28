{ config, pkgs, ... }:
{
  imports = [ ./dconf.nix ];

  home.username = "vignesh";
  home.homeDirectory = "/home/vignesh";

  home.packages = with pkgs; [
    yaru-theme

    # - system
    gnome.gnome-system-monitor
    gnome.seahorse # encryption keys and passwords
    gnome.nautilus
    gnome.gnome-terminal
    gnome.gnome-disk-utility
    gnome.gnome-clocks
    gnome.gnome-calculator
    gnome.baobab

    # - development
    python311Packages.python
    python311Packages.pip
    libgcc
    gfortran
    texliveMedium

    # - text editors
    gnome.gedit
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
    dconf2nix
    
    # - others
    libsForQt5.okular # pdf
    gnome.evince # pdf
    # libreoffice # office
    libsForQt5.kdeconnect-kde # wireless connection to other devices
    # geogebra # math graphing
    # telegram-desktop
  ];

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
      "powertop" = "sudo powertop";
      "gputop" = "sudo intel_gpu_top";
      "ram" = ''echo $(vmstat -s | grep "used memory" | tr -d -c 0-9 | awk '{printf ("🐏  %.2f\n GiB", $1 / 1024 / 1024)}')'';
      "power" = ''echo ⚡ $(upower -d | grep -m1 "energy-rate:" | tr -dc "(\.[0-9]+)?\b") W'';
      "gnome-wayland-debug" = "dbus-run-session -- gnome-shell --nested --wayland";
      "hotspot" = "sudo create_ap --daemon wlp0s20f3 enp0s20f0u1 vignesh-inspiron 12341234";
      "hotspot-list" = "sudo create_ap --list-clients ap0";
      "hotspot-stop" = "sudo create_ap --stop ap0";
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

  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
    '';
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