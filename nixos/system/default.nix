{ config, pkgs, ... }:
{
  imports = [
    ./display.nix
    ./fingerprint.nix
    ./garbage.nix
    ./intel_gpu.nix
    ./networking.nix
    ./sound.nix
    ./thermals.nix
  ];
}
