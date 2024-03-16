{ config, pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./git.nix
    ./htop.nix
    ./neovim.nix
  ];
}