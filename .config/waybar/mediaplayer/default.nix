{ pkgs, ... }:

pkgs.python3Packages.buildPythonApplication rec {
  pname = "waybar-mediaplayer";
  version = "1.0";

  nativeBuildInputs = with pkgs; [
    wrapGAppsHook3
    gobject-introspection
  ];

  buildInputs = with pkgs; [
    playerctl
  ];

  dependencies = with pkgs.python3Packages; [
    pygobject3
  ];

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  src = ./.;
}
