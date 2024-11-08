{ lib, inputs, system, ... }:
let
  pkgs = import inputs.nixpkgs-unstable {
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
  iiserpune-login-daemon = pkgs.callPackage ./iiserpune-login-daemon { };
}
