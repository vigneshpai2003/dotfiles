{ config, pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./brave.nix
    ./btop.nix
    ./cava
    ./git.nix
    ./htop.nix
    ./kdeconnect.nix
    ./tilix
    ./vscode.nix
  ];
}
