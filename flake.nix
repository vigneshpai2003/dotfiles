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
        system = "x86_64-linux";
        extra = {
          pkgs-stable = import nixpkgs-stable { system = "x86_64-linux"; config.allowUnfree = true; };
        };
      in
      nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = extra;
        modules = [
          ./hosts/inspiron

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = extra;
            home-manager.users.vignesh = import ./home;
          }
        ];
      };
  };
}
