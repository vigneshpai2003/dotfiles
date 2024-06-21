{ lib
, python3Packages
, chromedriver
, chromium
, wrapGAppsNoGuiHook
, gobject-introspection
}:

python3Packages.buildPythonApplication rec {
  pname = "iiserpune-selenium-login";
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
    selenium
    keyring
    pydbus
    pygobject3
  ] ++ [
    chromedriver
    chromium
  ];

  dontWrapGApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
  '';

  src = ./.;

  meta = with lib; {
    description = "A simple login script for IISER Pune student networks using selenium.";
    platforms = platforms.linux;
    mainProgram = "iiserpune-selenium-login";
    priority = 1;
  };
}
