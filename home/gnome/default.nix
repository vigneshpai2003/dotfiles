{ config, pkgs, ... }:
{
  imports = [
    ./utilities.nix
    ./extensions.nix
    ./dconf.nix
  ];
}