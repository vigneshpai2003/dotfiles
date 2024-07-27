{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      popupLyrics
      powerBar
    ];

    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
      historyInSidebar
    ];

    theme = spicePkgs.themes.sleek;

    colorScheme = "Cherry";
  };
}
