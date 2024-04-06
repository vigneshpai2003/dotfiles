{ config, pkgs, ... }:
{
  xdg.desktopEntries = {
    balenaEtcher = {
      name = "Balena Etcher";
      genericName = "USB";
      exec = ''appimage-run ${config.home.homeDirectory}/nix/external/etcher/balenaEtcher-1.18.11-x64.AppImage'';
      terminal = false;
      icon = "${config.home.homeDirectory}/nix/external/etcher/etcher.png";
    };
  };
}
