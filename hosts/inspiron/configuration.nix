{ config, pkgs, username, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../nixos/system
    ../../nixos/hyprland.nix
    ../../nixos/flatpak.nix
    ../../nixos/virtualization.nix
    ../../nixos/locale.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    trusted-users = [ username ];

    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];

    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  # - Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
    };
  };

  # - Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # - Users
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "kvm" ];
  };

  environment.systemPackages = with pkgs; [
    linux-wifi-hotspot # - Hotspot GUI
  ];

  programs.kdeconnect.enable = true;

  # - direnv
  programs.direnv.enable = true;

  # - WayDroid
  virtualisation.waydroid.enable = true;

  # - Podman (required for distrobox)
  virtualisation.podman.enable = true;

  # - SSH
  services.openssh.enable = true;

  # - Firmware Updater
  services.fwupd.enable = true;

  # - Enable CUPS to print documents.
  services.printing.enable = true;

  # - Fonts
  fonts.packages = with pkgs; [
    font-awesome
    open-sans
    noto-fonts
    noto-fonts-color-emoji
    nerdfonts
  ];

  # - Add ~/.local/bin to PATH (important for local installation of distrobox)
  environment.localBinInPath = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
