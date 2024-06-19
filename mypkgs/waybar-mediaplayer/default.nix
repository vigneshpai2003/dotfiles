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

  build-system = with python3Packages; [
    setuptools
  ];

  dependencies = with python3Packages; [
    pygobject3
  ] ++ [ playerctl ];

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  src = ./.;

  meta = with lib; {
    description = "A simple media player widget backend for Waybar";
    platforms = platforms.linux;
    mainProgram = "waybar-mediaplayer";
  };
}
