{ pkgs, config, ...}:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wofi
    waybar
  ];
}