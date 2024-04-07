{ config, pkgs, ... }:
{
  xdg.desktopEntries = {
    warp-terminal = {
      name = "Warp";
      genericName = "terminal";
      exec = ''appimage-run ${config.home.homeDirectory}/nix/external/warp/Warp-x86_64.AppImage'';
      terminal = false;
      icon = "${config.home.homeDirectory}/nix/external/warp/warp.png";
    };
  };
}
