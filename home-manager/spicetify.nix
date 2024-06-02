{ pkgs, lib, inputs, ... }:
let
  inherit (inputs) spicetify;
  spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;
in
{
  # import the flake's module for your system
  imports = [ spicetify.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      powerBar
      history
    ];
  };

  # spotify must be run with xwayland due to window decoration issues
  xdg.desktopEntries.spotify = {
    name = "Spotify";
    genericName = "Music Player";
    exec = "spotify --ozone-platform=x11";
    icon = "spotify-client";
    mimeType = [ "x-scheme-handler/spotify" ];
    categories = [ "Audio" "Music" "Player" "AudioVideo" ];
  };
}
