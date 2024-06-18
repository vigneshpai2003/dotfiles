{ config, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      "rebirth" = "sudo nixos-rebuild switch --flake";
      "cd" = "z";
      "btop" = "btop --utf-force";
      "powertop" = "sudo powertop";
      "gputop" = "sudo intel_gpu_top";
      "fetch" = "fastfetch";
      "power" = ''bc -l <<< $(cat /sys/class/power_supply/BAT0/current_now)*$(cat /sys/class/power_supply/BAT0/voltage_now)/1000000000000'';

      "dell-thermal-status" = "sudo cctk --ThermalManagement | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-thermal-cool" = "sudo cctk --ThermalManagement=Cool | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-thermal-quiet" = "sudo cctk --ThermalManagement=Quiet | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-thermal-optimized" = "sudo cctk --ThermalManagement=Optimized | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-thermal-ultra" = "sudo cctk --ThermalManagement=UltraPerformance | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";

      "dell-battery-status" = "sudo cctk --PrimaryBattChargeCfg | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-battery-standard" = "sudo cctk --PrimaryBattChargeCfg=Standard | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-battery-express" = "sudo cctk --PrimaryBattChargeCfg=Express | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-battery-custom" = "sudo cctk --PrimaryBattChargeCfg=Custom:85-90 | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";

      "waydroid-terminate" = "waydroid session stop && sudo waydroid container stop && rm ~/.local/share/applications/waydroid.*";
      "waydroid-default" = ''waydroid prop set persist.waydroid.width "" && waydroid prop set persist.waydroid.height "" && waydroid session stop'';
      "waydroid-vertical" = "waydroid prop set persist.waydroid.width 720 && waydroid prop set persist.waydroid.height 1080 && waydroid session stop";

      "appletv" = ''uxplay -p -vsync no'';

      "flake-dev" = ''touch flake.nix .envrc && echo '{
  description = "nix flake environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs
          (python311.withPackages (pypkgs: with pypkgs; [
            numpy
          ]))
        ];
      };
    };
}' > flake.nix && echo 'use flake' > .envrc
'';
    };
  };
}
