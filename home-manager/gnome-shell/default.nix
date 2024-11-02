{ config, pkgs, ... }:
{
  imports = [
    ./desktop.nix
    ./extensions.nix
    ./theme.nix
  ];
}
