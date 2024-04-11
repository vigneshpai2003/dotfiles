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
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit inputs nixpkgs nixpkgs-stable home-manager system;
          inherit (nixpkgs) lib;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
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
          };
        }
      );
    };
}
