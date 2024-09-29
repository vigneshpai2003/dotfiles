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

    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    riseup.url = "github:vigneshpai2003/nixpkgs/riseup-vpn";
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
