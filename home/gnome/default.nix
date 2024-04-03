{ config, pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./terminal.nix
    ./shell
  ];
}
