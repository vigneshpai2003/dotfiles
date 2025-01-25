{ lib, inputs, mypkgs, system, ... }:
{
  inspiron =
    let
      hostname = "inspiron";
      username = "vignesh";
      dotdir = "/home/${username}/dotfiles";
      packages = import inputs.nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
        overlays = [
          (final: prev: {
            stable = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };

            master = import inputs.nixpkgs-master {
              inherit system;
              config.allowUnfree = true;
            };

            inherit mypkgs;
          })
        ];
      };
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs username hostname dotdir packages;
      };

      modules = [
        ./${hostname}/configuration.nix
      ];
    };
}
