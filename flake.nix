{
  description = "System flake";

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
      inherit (inputs.nixpkgs) lib;
      genSystems = (lib.genAttrs [
        "aarch64-linux"
        "x86_64-linux"
      ]);
    in
    {
      packages = genSystems (system: import ./mypkgs {
        inherit lib inputs system;
      });

      nixosConfigurations = (
        import ./hosts {
          inherit lib inputs system;
          mypkgs = self.packages.${system};
        }
      );
    };
}
