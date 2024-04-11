{ lib, inputs, home-manager, system, username, pkgs, ... }:
{
  inspiron = lib.nixosSystem {
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
