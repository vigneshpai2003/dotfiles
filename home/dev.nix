{ config, pkgs, pkgs-stable, lib, ... }:
{
  home.packages = with pkgs; [
    # - languages, tools and frameworks
    ffmpeg
    fortls
    texliveFull
    direnv
    devbox

    # - text editors
    vscode
    flatpak-builder

    # - virtual machine, containers, emulation and remote machines
    virt-manager
    gnome.gnome-boxes
    boxbuddy # distrobox gui
    gnome-connections # connect to remote host
    filezilla # sftp / ftp
    bottles # wine
  ] ++ (with pkgs-stable; [
    gnome-builder
  ]);
}
