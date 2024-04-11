{ config, pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./brave.nix
    ./btop.nix
    ./git.nix
    ./htop.nix
    ./kdeconnect.nix
    ./neovim.nix
    ./vscode.nix
  ];
}
