{ config, pkgs, ... }:
{
  imports = [
    ./garbage.nix
    ./cachix.nix
    ./intel_gpu.nix
    ./networking.nix
    ./sound.nix
    ./thermals.nix
    ./fingerprint.nix
  ];

  # firmware updater
  services.fwupd.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
