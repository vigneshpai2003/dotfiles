{ pkgs, lib, inputs, ... }:
let
  inherit (inputs) spicetify;
  spicePkgs = inputs.spicetify.packages.${pkgs.system}.default;
  officialThemes = pkgs.fetchgit {
    url = "https://github.com/spicetify/spicetify-themes";
    rev = "dfdd89ad84d5c68915c65e4a83580047349c49b4";
    sha256 = "sha256-8IF2Y7xJtzk92rl4bfjiMXCISzUMaxXxOaMZkLS5mww=";
  };
in
{
  # import the flake's module for your system
  imports = [ spicetify.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify = {
    enable = true;
    theme = {
      name = "Sleek";
      src = officialThemes;

      appendName = true; # theme is located at "${src}/<name>" not just "${src}"
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };
    colorScheme = "Cherry";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      powerBar
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
