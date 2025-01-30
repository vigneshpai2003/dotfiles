{
  description = "System flake";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-snapd = {
      url = "github:nix-community/nix-snapd";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    iiserpune-login-daemon.url = "github:vigneshpai2003/iiserpune-login-daemon";
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
      inherit (inputs.nixpkgs-unstable) lib;
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit lib inputs system;
        }
      );
    };
}
