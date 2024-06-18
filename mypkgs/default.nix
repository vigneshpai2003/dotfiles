{ lib, inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs {
    inherit system;
    config.allowUnfree = true;
    overlays = [
      (final: prev: {
        stable = import inputs.nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };
      })
    ];
  };
in
{
  waybar-mediaplayer = (pkgs.callPackage ./waybar-mediaplayer { });
  iiserpune-selenium-login = (pkgs.callPackage ./iiserpune-selenium-login { }).override({
    python3Packages = pkgs.python312Packages;
  });
}
