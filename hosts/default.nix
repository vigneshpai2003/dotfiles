{ lib, inputs, nixpkgs, nixpkgs-stable, home-manager, username, ... }:
{
  inspiron =
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
              config.permittedInsecurePackages = [
                "electron-19.1.9"
              ];
            };
          })
        ];
        config.allowUnfree = true;
      };
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs username pkgs;
      };

      modules = [
        ./inspiron/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit inputs username pkgs;
            };
            users.${username} = {
              home.username = username;
              home.homeDirectory = "/home/${username}";
              imports = [ ./inspiron/home.nix ];
            };
          };
        }
      ];
    };
}
