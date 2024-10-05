{ pkgs, inputs, username, dotdir, system, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nix-snapd.nixosModules.default

    ./hardware-configuration.nix

    # ../../nixos/cosmic.nix
    ../../nixos/fingerprint.nix
    ../../nixos/flatpak.nix
    ../../nixos/hypridle.nix
    ../../nixos/hyprland.nix
    ../../nixos/intel_gpu.nix
    ../../nixos/locale.nix
    ../../nixos/networking.nix
    ../../nixos/security.nix
    ../../nixos/sound.nix
    ../../nixos/thermals.nix
  ];

  # - nix Settings
  nix = {
    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      trusted-users = [ username ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://cosmic.cachix.org/"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
      ];
    };
  };

  # - Home Manager Configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hmbak";
    extraSpecialArgs = {
      inherit inputs username dotdir pkgs;
    };
    users.${username} = {
      home.username = username;
      home.homeDirectory = "/home/${username}";
      imports = [ ./home.nix ];
    };
  };

  # - Boot
  boot = {
    # - Latest Kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # - Bootloader
    loader = {
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
  };

  # - Users
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "kvm" ];
  };

  security.sudo.extraRules = [
    {
      users = [ username ];
      commands = [
        {
          command = "/run/current-system/sw/bin/create_ap";
          options = [ "SETENV" "NOPASSWD" ];
        }
      ];
    }
  ];

  # - Packages that frequently require sudo permissions
  environment.systemPackages = with pkgs; [
    linux-wifi-hotspot # - Hotspot GUI
    resources # - System Monitor
    libimobiledevice # - Wired Connection to iPhone
    ifuse # - Mount iPhone
    master.riseup-vpn # - Riseup VPN
  ];

  # - Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # - Virtualisation
  virtualisation = {
    libvirtd.enable = true;
    kvmgt.enable = true;
    containers.enable = true;
    waydroid.enable = true;
    podman.enable = true;
  };

  services = {
    fwupd.enable = true; # - Firmware Updater
    printing.enable = true; # - Printing via CUPS
    snap.enable = true; # - Snap
    usbmuxd.enable = true; # - iOS Device Support
  };

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
