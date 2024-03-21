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

    appimage-run
    desktop-file-utils
    
    firefox # browser
    linux-wifi-hotspot # hotspot
    dell-command-configure # dell bios options
  ];
}