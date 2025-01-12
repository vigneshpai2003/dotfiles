{ dotdir, ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      "system-update" = "sudo nix flake update --flake ${dotdir}";
      "system-upgrade" = ''(sudo nixos-rebuild switch --flake ${dotdir} --show-trace && notify-send --icon="ghostwriter" "Arise" "Shadow extraction succeeded.") || notify-send --icon="ghostwriter" "Arise" "Shadow extraction failed."'';
      "generations-list" = "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
      "generations-delete" = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations old";
      "garbage-collect" = "sudo nix-collect-garbage; nix-collect-garbage";
      "system-clean" = "generations-delete && garbage-collect";
      "system-optimize" = "nix-store --optimise";

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
}
