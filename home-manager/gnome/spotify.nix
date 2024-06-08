{ config, ... }:
{
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
