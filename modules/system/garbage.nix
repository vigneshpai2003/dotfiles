{ pkgs, config, ... }:
{
  nix.optimise.automatic = true;

  # garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}
