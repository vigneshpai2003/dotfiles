{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # - languages, tools and frameworks
    (python311Packages.python.withPackages(p: with p; [
      numpy
      scipy
      matplotlib
      jupyter
    ]))
    sage
    gfortran
    fortls
    texliveFull
    direnv

    # - text editors
    vscode
    
    # - virtual machine, containers, emulation and remote machines
    virt-manager
    gnome.gnome-boxes
    podman
    distrobox # containerized linux
    gnome-connections # connect to remote host
    filezilla # sftp / ftp
    bottles # wine
  ];
}
