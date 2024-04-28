{ lib, inputs, system, ... }:
{
  inspiron =
    let
      hostname = "inspiron";
      username = "vignesh";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (final: prev: {
            stable = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
              config.permittedInsecurePackages = [
                "electron-19.1.9" # for balena etcher
              ];
            };
            inherit (inputs.nix-software-center.packages.${system}) nix-software-center;
          })
        ];
      };
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs username hostname pkgs;
      };

      modules = [
        ./${hostname}/configuration.nix

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs username hostname pkgs;
            };
            users.${username} = {
              home.username = username;
              home.homeDirectory = "/home/${username}";
              imports = [ ./${hostname}/home.nix ];
            };
          };
        }

        inputs.nix-snapd.nixosModules.default
        {
          services.snap.enable = true;
        }
      ];
    };
}
