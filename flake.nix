{
  description = "System flake";
  # build using: sudo nixos-rebuild switch --flake .

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify.url = "github:the-argus/spicetify-nix";
    ags.url = "github:Aylur/ags";
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit inputs system;
          inherit (inputs.nixpkgs) lib;
        }
      );
    };
}
