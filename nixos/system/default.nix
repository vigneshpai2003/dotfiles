{ config, pkgs, ... }:
{
  imports = [
    ./garbage.nix
    ./intel_gpu.nix
    ./networking.nix
    ./sound.nix
    ./thermals.nix
    ./fingerprint.nix
  ];
}
