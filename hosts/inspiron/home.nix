{ pkgs, dotdir, ... }:
{
  imports = [
    ../../home-manager/bash.nix
    ../../home-manager/hyprland.nix
    ../../home-manager/nautilus
    ../../home-manager/spicetify.nix
    ../../home-manager/theme.nix
    ../../home-manager/xdg-desktop-entries.nix
  ];

  home.sessionVariables = {
    DOTDIR = dotdir;
  };

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

    # - Terminal Emulator
    kitty = {
      enable = true;
      theme = "Catppuccin-Mocha";
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
          gradient_count = 3;
          gradient_color_1 = "'#81c8be'";
          gradient_color_2 = "'#e78284'";
          gradient_color_3 = "'#f4b8e4'";
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
    nvtopPackages.full
    libva-utils
    vulkan-tools
    lm_sensors # - Temperature Sensors
    powertop # - Power Management
    impression # - Bootable Drive Creator
    baobab # - Disk Tools
    gnome-disk-utility
    nvme-cli
    gnome.gnome-logs # - Logs
    gnome.gnome-characters # - Emojis
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
    mypkgs.iiserpune-login-daemon # - IISER Pune LAN Login
    openvpn # - VPN
    localsend # - Share Files

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
    zed-editor
    gnome-text-editor

    ### - ags
    bun
    dart-sass
    fd
    wf-recorder
    wayshot
    swappy

    ### - Audio/Video Tools
    pwvucontrol # - PipeWire Audio Control
    pavucontrol # - PulseAudio Audio Control
    playerctl # - Media Control
    ffmpeg # - Audio Video Library
    mpv # - Media Players
    vlc
    livecaptions # - Live Captions
    uxplay # - iPhone Mirroring
    snapshot # - Camera
    cli-visualizer # - Audio Visualizer

    ### - General/Office Tools
    firefox # - Browser
    brave
    evince # - Document Viewer
    papers
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
    gnome-calculator # - Calculator
    telegram-desktop # - Telegram
    zoom-us # - Zoom
    dialect # - Translations
    gnome.gnome-clocks # - Clock
    gnome.gnome-maps # - Maps
    mousam # - Weather
    gnome-calendar # - Calendar

    ### - Games
    gnome.gnome-mines # - Minesweeper
    smassh # - Typing Game

    ### - Hyprland/Wayland Desktop Tools
    wofi # - Launcher
    waybar # - Bar
    mypkgs.waybar-mediaplayer
    wl-clipboard # - Wayland Copy Paste
    wlsunset # - Night Light
    hyprshade # - Custom Shaders
    hyprpaper # - Wallpaper Manager
    hyprpicker # - Color Picker
    cliphist # - Clipboard Manager
    grim # - Screen Capture
    slurp # - Select Screen Region
    grimblast # - Screen Capture GUI
    # kooha # - Screen Recorder GUI # - Not Working, use flatpak
    gsettings-desktop-schemas # - gsettings Schemas
  ];

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
