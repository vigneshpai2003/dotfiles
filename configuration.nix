{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./settings/garbage.nix
      ./settings/intel_gpu.nix
      ./settings/packages.nix
      ./settings/gnome.nix
      ./settings/flatpak.nix
      ./settings/iiser.nix
    ];

  # NixOS settings
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

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
  networking.networkmanager.enable = true;
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

  # Power Management
  powerManagement.enable = true;
  services.thermald.enable = true;
  
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
