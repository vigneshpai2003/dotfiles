{ pkgs, inputs, username, dotdir, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
  ];

  # - Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = "source = ~/${dotdir}/.config/hypr/hyprland.conf";
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [ ];
    settings.env = [
      "DOTDIR, ${dotdir}"
    ];
  };

  # - Hyprlock configuration
  programs.hyprlock = {
    enable = true;
    extraConfig = "source = ~/${dotdir}/.config/hypr/hyprlock.conf";
    settings = {
      "$dotdir" = dotdir;
    };
  };

  programs.ags = {
    enable = true;
    configDir = null;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
