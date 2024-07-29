{ lib, dotdir, ... }:
let
  variables = {
    DOTDIR = dotdir;
  };
in
{
  home.sessionVariables = variables;

  wayland.windowManager.hyprland.settings.env =
    let
      names = builtins.attrNames variables;
      values = builtins.attrValues variables;
      range = lib.lists.range 0 (builtins.length names - 1);
    in
    map (i: "${builtins.elemAt names i},${builtins.elemAt values i}") range;
}
