{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    # - languages, tools and frameworks
    ffmpeg
    fortls
    texliveFull
    direnv

    (
      let
        envname = "pydev";
        packages = with pkgs; [
          (python311Packages.python.withPackages (p: with p; [
            pip
            numpy
            scipy
            matplotlib
          ]))
          jupyter
        ];
      in
      pkgs.runCommand envname
        {
          buildInputs = packages;
          nativeBuildInputs = [ pkgs.makeWrapper ];
        }
        ''
          mkdir -p $out/bin/
          ln -s ${pkgs.bashInteractive}/bin/bash $out/bin/${envname}
          wrapProgram $out/bin/${envname} --prefix PATH : ${pkgs.lib.makeBinPath packages}
        ''
    )

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
