{ lib
, python3Packages
, firefox
}:

python3Packages.buildPythonApplication rec {
  pname = "iiserpune-selenium-login";
  version = "1.0";
  format = "pyproject";

  nativeBuildInputs = [
    firefox
  ];

  build-system = with python3Packages; [
    setuptools
  ];

  dependencies = with python3Packages; [
    selenium
    keyring
    secretstorage
    dbus-python
  ];

  src = ./.;

  meta = with lib; {
    description = "A simple login script for IISER Pune student networks using selenium.";
    platforms = platforms.linux;
    mainProgram = "iiserpune-selenium-login";
  };
}
