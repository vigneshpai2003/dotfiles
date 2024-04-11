{ lib, inputs, nixpkgs, nixpkgs-stable, home-manager, username, ... }:
{
  inspiron =
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          "electron-19.1.9"
        ];
      };
    in
    lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs username pkgs pkgs-stable;
      };

      modules = [
        ./inspiron/configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit nixpkgs-stable username pkgs pkgs-stable;
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
