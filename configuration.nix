{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # NixOS settings
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  nix.optimise.automatic = true;

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use Virtualization
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.kvmgt.enable = true;
  virtualisation.containers.enable = true;

  # Enable networking
  networking.networkmanager = {
    enable = true;
    dispatcherScripts = [ {
      source = pkgs.writeText "IISERlogin" ''
        #!/usr/bin/env ${pkgs.bash}/bin/bash

        if [[ "$2" == "up" ]]; then
          export HOME=/home/vignesh/
          /home/vignesh/Apps/bin/caa -d --log=/home/vignesh/Apps/logs/caa.log
          logger "Started IISER login daemon"
        fi

        if [[ "$2" == "down" ]]; then
          export HOME=/home/vignesh/
          /home/vignesh/Apps/bin/caa -s
          logger "Stopped IISER login daemon"
        fi
      '';
      type = "basic";
      }
    ];
  };
  networking.hostName = "vignesh-inspiron";

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.libinput.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = with pkgs; [gnome-tour];

  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.vignesh = {
    isNormalUser = true;
    description = "vignesh";
    extraGroups = [ "networkmanager" "wheel" "kvm"];
  };

  services.flatpak.enable = true;

  # GPU stuff
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      mesa.drivers
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
	
  # Power Management
  powerManagement.enable = true;
  services.thermald.enable = true;
  services.openssh.enable = true;

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
  ];

  # programs.nix-ld.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
