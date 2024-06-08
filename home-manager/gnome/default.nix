{ config, pkgs, ... }:
{
  imports = [
    ./shell
    ./keybindings.nix
    ./packages.nix
    ./spotify.nix
    ./tilix.nix
  ];
}
