{ config, pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./extensions.nix
    ./dock.nix
    ./monitering.nix
    ./theme.nix
  ];
}
