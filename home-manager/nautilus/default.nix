{ config, pkgs, username, ... }:
let 
  extension_dir = "/etc/profiles/per-user/${username}/lib/nautilus/extensions-4";
in
{
  home.packages = with pkgs; [
    nautilus
    nautilus-python
  ];

  # - the actual extension
  home.file."${config.xdg.dataHome}/nautilus-python/extensions/nautilus-kitty.py".source = ./nautilus-kitty.py;

  # - set environment variable in Hyprland
  wayland.windowManager.hyprland.settings = {
    env = [
      "NAUTILUS_4_EXTENSION_DIR,${extension_dir}"
    ];

    "$nautilus" = "NAUTILUS_4_EXTENSION_DIR=${extension_dir} nautilus -w";
  };
}
