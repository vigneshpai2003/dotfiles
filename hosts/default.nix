{ lib, inputs, mypkgs, system, ... }:
{
  inspiron =
    let
      hostname = "inspiron";
      username = "vignesh";
      dotdir = "/home/${username}/dotfiles";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
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

            my-riseup-vpn = (import inputs.riseup {
              inherit system;
              config.allowUnfree = true;
            }).riseup-vpn;
          })
        ];
      };
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs username hostname dotdir pkgs;
      };

      modules = [
        ./${hostname}/configuration.nix
      ];
    };
}
