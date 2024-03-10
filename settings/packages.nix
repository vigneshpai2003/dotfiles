{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    neofetch
    cpufetch
    lm_sensors
    powertop
    htop
    btop
    powerstat
    intel-gpu-tools
    firefox
    zip
    unzip
    linux-wifi-hotspot
    dell-command-configure

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