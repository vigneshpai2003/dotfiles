{ config, pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./dock.nix
    ./extensions.nix
    ./monitering.nix
    ./spotlight.nix
    ./theme.nix
  ];
}
