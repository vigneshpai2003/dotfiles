{ config, pkgs, pkgs-stable, ... }:
{
  imports = [
    ../../home-manager/dev.nix
    ../../home-manager/desktopEntries.nix
    ../../home-manager/gnome
    ../../home-manager/config
  ];

  home.packages = with pkgs; [
    # - Office Tools
    libreoffice
    marktext
    obsidian

    # - Pictures
    loupe
    pinta
    inkscape

    # - Audio Video
    pavucontrol
    mpv
    vlc
    spotify
    # spotify # install using flatpak instead (weird titlebar in nixpkgs)

    # - VPN
    riseup-vpn

    # - KDE Connect GUI
    libsForQt5.kdeconnect-kde

    # - Math Graphing
    geogebra6

    # - Social
    telegram-desktop

    # - Warp Terminal
    (import ../../external/warp/package.nix {
      lib = lib;
      inherit (pkgs)
        stdenvNoCC
        stdenv
        fetchurl
        autoPatchelfHook
        undmg
        zstd
        curl
        fontconfig
        libglvnd
        libxkbcommon
        vulkan-loader
        xdg-utils
        xorg
        zlib;
    })
  ] ++ (with pkgs-stable; [
    # - Burn ISO to USB
    etcher
  ]);

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
