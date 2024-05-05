{ pkgs, config, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.libinput.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
