# dotfiles

These are my personal nixos system configuration files using flakes. You can use this configuration by replacing the contents of `hosts/<hostname>` with your own `configuration.nix`, `hardware-configuration.nix` and `home.nix` if you use home-manager.

Remember to modify `hosts/default.nix` appropriately as well with the correct hostname and username.

## Important Notes
- Modify `home-manager/config/git.nix` with your user name and email.
- `external/caa` is applicable only for IISER Pune students, please modify `external/caa/.caa/ca-cert.pem` with your credentials after reading the README in the same directory.
- `external/warp` was copied from the github repo of NixOS. Since Warp frequently releases updates, relying on the `nixpkgs-unstable` version is not reliable.
- `distrobox` is best installed locally from their GitHub repo since the nixpkgs version mounts `/nix` in the containers which leads to problems.

## TODO
- dconf and GTK theming
- make bluetooth headset default using wpctl when connected
- cursor themes
- customize waybar
- dunst theme
- wofi theme
- colume and brightness sliders using eww
- caffeine extension using hypridle and environment variables
- eww bar
