{ config, pkgs, ... }:
{
  imports = [
    ./garbage.nix
    # ./cachix.nix
    ./intel_gpu.nix
    ./networking.nix
    ./sound.nix
    ./thermals.nix
    ./fingerprint.nix
  ];
}
