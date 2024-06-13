# dotfiles

These are my personal nixos system configuration files using flakes.

## Important Notes
- Modify `home-manager/config/git.nix` with your user name and email.
- `caa` is applicable only for IISER Pune students, please modify `caa/.caa/ca-cert.pem` with your credentials after reading the README in the same directory.
- `distrobox` is best installed locally from their GitHub repo since the nixpkgs version mounts `/nix` in the containers which leads to problems.

## TODO
- inspect caa issues, add it to bar
- make bluetooth headset default using wpctl when connected
- cursor themes
- customize waybar
- wofi theme
- colume and brightness sliders using eww
- caffeine extension (using hypridle?)
- eww bar
