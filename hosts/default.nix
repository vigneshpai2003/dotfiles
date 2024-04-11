{ lib, inputs, home-manager, system, pkgs, ... }:
{
  inspiron =
    let
      hostname = "inspiron";
      username = "vignesh";
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs username hostname pkgs;
      };

      modules = [
        ./${hostname}/configuration.nix

        home-manager.nixosModules.home-manager
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
      ];
    };
}
