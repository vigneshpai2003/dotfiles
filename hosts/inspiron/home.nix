{ config, inputs, pkgs, ... }:
{
  imports = [
    ../../home-manager/bash.nix
    ../../home-manager/hyprland.nix
    ../../home-manager/nautilus
    ../../home-manager/spicetify.nix
    ../../home-manager/theme.nix
    ../../home-manager/xdg-desktop-entries.nix
  ];

  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };

  programs = {
    # - git
    git = {
      enable = true;
      userName = "Vignesh Pai";
      userEmail = "vigneshpai2003@gmail.com";
    };

    # - Terminal System Monitor
    htop = {
      enable = true;
      settings = {
        show_cpu_usage = 1;
        show_cpu_frequency = 1;
        show_cpu_temperature = 1;
      };
    };

    btop.enable = true;

    # - Fuzzy File Search in Terminal
    fzf.enable = true;

    # - Fuzzy cd
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    # - Terminal Emulator
    kitty = {
      enable = true;
      theme = "Chalk";
      shellIntegration.enableBashIntegration = true;
      settings = {
        background_opacity = "0.8";
      };
    };

    # - Audio Visualizer
    cava = {
      enable = true;
      settings = {
        color = {
          gradient = 1;
          gradient_count = 2;
          gradient_color_1 = "'#fc5c7d'";
          gradient_color_2 = "'#6a82fb'";
        };
      };
    };
  };

  home.packages = with pkgs; [
    ### - System Tools
    fastfetch # - System Info
    dell-command-configure # - Dell BIOS options
    cpufetch # - CPU Info
    geekbench # - CPU Benchmarker
    intel-gpu-tools # - GPU Tools
    libva-utils
    vulkan-tools
    lm_sensors # - Temperature Sensors
    powertop # - Power Management
    gnome.baobab # - Disk Tools
    gnome.gnome-disk-utility
    nvme-cli
    gnome.gnome-logs # - Logs
    brightnessctl # - Brightness Control
    curl # - Download Tools
    wget
    zip # - Compression
    unzip
    desktop-file-utils # - .desktop File Support
    libnotify # - Notifications Library

    ### - Development Tools
    nixpkgs-fmt # - .nix File Formatter
    tree # - Directory Tree
    libgcc # - Build Tools
    gnumake
    gnome-builder
    flatpak-builder
    appimage-run # - Appimage Support
    texliveFull # - LaTeX Compiler
    gnome.gnome-boxes # - Virtual Machine Manager
    boxbuddy # - Distrobox GUI
    bottles # - Wine
    gnome-connections # - Remote Connections
    filezilla # - FTP Client
    master.vscode # - Text Editors
    master.zed-editor

    ### - Audio/Video Tools
    pavucontrol # - Audio Control
    playerctl # - Media Control
    ffmpeg # - Audio Video Library
    mpv # - Media Players
    vlc
    livecaptions # - Live Captions
    uxplay # - iPhone Mirroring

    ### - General/Office Tools
    firefox # - Browser
    brave
    gnome.evince # - Document Viewer
    wike # - Wikipedia App
    marktext # - Markdown Editor
    obsidian
    libreoffice # - Office Tools
    onlyoffice-bin_latest
    pdfarranger # - pdf Editor
    loupe # - Image Viewer
    pinta # - Image Editor
    inkscape # - Vector Graphics Editor
    geogebra6 # - Math Graphing
    telegram-desktop # - Telegram
    zoom-us # - Zoom
    dialect # - Translations

    ### - Hyprland/Wayland Desktop Tools
    wofi # - Launcher
    waybar # - Bar
    mypkgs.waybar-mediaplayer
    dunst # - Notifications Daemon
    wl-clipboard # - Wayland Copy Paste
    cliphist # - Clipboard Manager
    grim # - Screen Capture
    slurp # - Select Screen Region
    grimblast # - Screen Capture GUI
    gsettings-desktop-schemas # - gsettings Schemas

    mypkgs.iiserpune-selenium-login # - IISER Pune LAN Login
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
