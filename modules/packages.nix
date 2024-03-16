{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    # essentials
    git
    curl
    wget
    neofetch
    cpufetch
    tree
    zip
    unzip
    htop
    btop
    
    firefox # browser
    linux-wifi-hotspot # hotspot
    dell-command-configure # dell bios options

    # build tools
    taglib
    openssl
    libxml2
    libxslt
    libzip
    zlib
    libgcc
  ];
}