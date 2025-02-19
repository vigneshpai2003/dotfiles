{ packages, dotdir, ... }:
{
  imports = [
    ../../home-manager/bash.nix
    ../../home-manager/spicetify.nix
    ../../home-manager/theme.nix
    ../../home-manager/xdg-desktop-entries.nix
  ];

  programs = {
    # - git
    git = {
      enable = true;
      userName = "Vignesh Pai";
      userEmail = "vigneshpai2003@gmail.com";
    };

    # - direnv for Development Environments
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
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
  };

  home.packages = with packages; [
    ### - System Tools
    fastfetch # - System Info
    stable.dell-command-configure # - Dell BIOS options
    cpufetch # - CPU Info
    intel-gpu-tools # - GPU Tools
    nvtopPackages.full
    libva-utils
    vulkan-tools
    smartmontools # - SSD Tools
    lm_sensors # - Temperature Sensors
    powertop # - Power Management
    impression # - Bootable Drive Creator
    baobab # - Disk Tools
    gnome-disk-utility
    nvme-cli
    usbutils # - USB Information
    pciutils # - PCI Information
    gnome-logs # - Logs
    gnome-characters # - Emojis
    gnome-font-viewer # - Installed Fonts
    brightnessctl # - Brightness Control
    curl # - Download Tools
    wget
    jq # - JSON Parser
    zip # - Compression
    unzip
    desktop-file-utils # - .desktop File Support
    libnotify # - Notifications Library
    gnome-firmware # - Firmware Updater
    iiserpune-login-daemon # Login Daemon
    openvpn # - VPN

    ### - Development Tools
    nixpkgs-fmt # - .nix File Formatter
    tree # - Directory Tree
    libgcc # - Build Tools
    gnumake
    appimage-run # - Appimage Support
    texliveFull # - LaTeX Compiler
    d2 # - Text to Image
    gnome-boxes # - Virtual Machine Manager
    distrobox # - Linux Containers
    boxbuddy # - distrobox GUI
    bottles # - Wine
    gnome-connections # - Remote Connections
    vscode # - Text Editors
    gnome-text-editor

    ### - Audio/Video Tools
    pavucontrol # - PulseAudio Audio Control
    playerctl # - Media Control
    ffmpeg # - Audio Video Library
    mpv # - Media Players
    vlc
    livecaptions # - Live Captions
    snapshot # - Camera
    gnome-network-displays # Screenshare

    ### - General/Office Tools
    firefox # - Browser
    brave
    evince # - Document Viewer
    papers
    obsidian # - Markdown Editor
    libreoffice # - Office Tools
    onlyoffice-bin_latest
    pdfarranger # - pdf Editor
    loupe # - Image Viewer
    pinta # - Image Editor
    inkscape # - Vector Graphics Editor
    geogebra6 # - Math Graphing
    gnome-calculator # - Calculator
    telegram-desktop # - Telegram
    zoom-us # - Zoom
    dialect # - Translations
    gnome-clocks # - Clock
    gnome-maps # - Maps
    mousam # - Weather
    gnome-calendar # - Calendar

    ### - Games
    gnome-mines # - Minesweeper
    keypunch # - Typing Game

    ### - Android
    android-tools # - ADB
    scrcpy # - Screen Mirroring
    android-studio # - Android Development
    httptoolkit # - HTTP Interception

    ### - Gnome Shell
    gnome-tweaks
    # gnome-extension-manager # - Use flatpak, currently incompatible with Gnome 47
  ]
  ++
  (with packages.gnomeExtensions; [
    alphabetical-app-grid
    battery-time-2
    blur-my-shell
    transparent-top-bar
    user-themes
    tiling-assistant
    clipboard-indicator
    caffeine
    live-captions-assistant
    open-bar
    search-light
  ]);

  xdg.userDirs.enable = true;

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
