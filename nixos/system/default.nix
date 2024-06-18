{ config, pkgs, ... }:
{
  imports = [
    ./fingerprint.nix
    ./garbage.nix
    ./intel_gpu.nix
    ./networking.nix
    ./sound.nix
    ./thermals.nix
  ];
}
