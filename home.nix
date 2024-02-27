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

    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
    gnomeExtensions.runcat

    # - others
    libsForQt5.okular # pdf
    # libreoffice # office
    libsForQt5.kdeconnect-kde # wireless connection to other devices
    # geogebra # math graphing
    # telegram-desktop
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      disabled-extensions = [
        "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
        "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
        "apps-menu@gnome-shell-extensions.gcampax.github.com"
        "window-list@gnome-shell-extensions.gcampax.github.com"
        "places-menu@gnome-shell-extensions.gcampax.github.com"
        "native-window-placement@gnome-shell-extensions.gcampax.github.com"
      ];

      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "runcat@kolesnikov.se"
        "dash-to-dock@micxgx.gmail.com"
        "gsconnect@andyholmes.github.io"
      ];
    };

    "org/gnome/shell/extensions/runcat" = {
        idle-threshold = 10;
        displaying-items = "character-and-percentage";
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
        background-opacity = 0.8;
        transparency-mode = "DYNAMIC";

        customize-alphas = true;
        max-alpha = 0.8;
        min-alpha = 0.0;
        
        dash-max-icon-size = 64;
        dock-position = "BOTTOM";
        height-fraction = 0.9;
        
        isolate-locations = true;
        isolate-workspaces = true;
        
        show-mounts = false;
        show-show-apps-button = false;
        show-trash = false;
    };
  };

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