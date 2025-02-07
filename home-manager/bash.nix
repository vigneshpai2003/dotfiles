{ dotdir, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
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

      "flake-dev" = ''touch flake.nix .envrc && echo '${builtins.readFile ./flake.template}' > flake.nix && echo 'use flake' > .envrc'';
    };
  };

  home.packages = with pkgs; [
    (pkgs.writeShellScriptBin "os" (builtins.replaceStrings
      [ "@DOTDIR@" ]
      [ dotdir ]
      (builtins.readFile ./scripts/os.sh)))
  ];
}
