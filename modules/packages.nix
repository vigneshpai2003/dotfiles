{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    # command line essentials
    git
    curl
    wget
    zip
    unzip
    tree
    fzf
    zoxide # cd alternative
    nixpkgs-fmt

    # build tools
    taglib
    openssl
    libxml2
    libxslt
    libzip
    zlib
    libgcc

    # system info
    neofetch
    cpufetch
    htop
    btop
    nvme-cli

    appimage-run
    desktop-file-utils

    firefox # browser
    linux-wifi-hotspot # hotspot
    dell-command-configure # dell bios options
  ];

  fonts.packages = with pkgs; [
    open-sans
    noto-fonts
    noto-fonts-color-emoji
    nerdfonts
  ];

  environment.localBinInPath = true;
}
