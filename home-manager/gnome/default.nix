{ config, pkgs, ... }:
{
  imports = [
    ./shell
    ./keybindings.nix
    ./packages.nix
    ./tilix.nix
  ];
}
