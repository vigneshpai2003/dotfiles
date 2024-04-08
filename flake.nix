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

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs: {
    nixosConfigurations.vignesh-inspiron =
      let
        username = "vignesh";
        system = "x86_64-linux";
        extra = {
          pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
          pkgs-stable = import nixpkgs-stable { system = system; config.allowUnfree = true; };
        };
      in
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = extra;
        modules = [
          ./hosts/inspiron

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = extra;
              users.${username} = {
                home.username = username;
                home.homeDirectory = "/home/${username}";
                imports = [ ./home ];
              };
            };
          }
        ];
      };
  };
}
