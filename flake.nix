{
  description = "System flake";
  # build using: sudo nixos-rebuild switch --flake .

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
    let
      username = "vignesh";
      hostname = "vignesh-inspiron";
      hostDir = "inspiron";
      system = "x86_64-linux";
      extra = {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
          config.permittedInsecurePackages = [
            "electron-19.1.9" # for balena etcher
          ];
        };
      };
    in
    {
      nixosConfigurations.${hostname} =
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = extra;
          modules = [
            ./hosts/${hostDir}/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = extra;
                users.${username} = {
                  home.username = username;
                  home.homeDirectory = "/home/${username}";
                  imports = [ ./hosts/${hostDir}/home.nix ];
                };
              };
            }
          ];
        };
    };
}
