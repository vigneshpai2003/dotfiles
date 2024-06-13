# mypkgs

This directory contains some scripts and packages I use.
It is both an independent flake and something that can be directly imported into other
nix files using `default.nix`. Packages can be built by executing `nix build .#pkgname` in this directory.

The individual directories have their own `flake.nix` which is meant to be
a development environment to be used in conjunction with `direnv`.