{ lib
, python3Packages
, wrapGAppsNoGuiHook
, gobject-introspection
, playerctl
}:

python3Packages.buildPythonApplication rec {
  pname = "waybar-mediaplayer";
  version = "1.0";
  format = "pyproject";

  nativeBuildInputs = [
    wrapGAppsNoGuiHook
    gobject-introspection
  ];

  buildInputs = [
    playerctl
  ];

  dependencies = with python3Packages; [
    setuptools
    pygobject3
  ];

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  src = ./.;

  meta = with lib; {
    description = "A simple media player widget backend for Waybar";
    platforms = platforms.linux;
    mainProgram = "mediaplayer.py";
  };
}
