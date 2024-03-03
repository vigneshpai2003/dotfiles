{config, pkgs, ...}:
{
  programs.git = {
    enable = true;
    userName = "Vignesh Pai";
    userEmail = "vigneshpai2003@gmail.com";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
      "btop" = "btop --utf-force";
      "powertop" = "sudo powertop";
      "gputop" = "sudo intel_gpu_top";
      "ram" = ''echo $(vmstat -s | grep "used memory" | tr -d -c 0-9 | awk '{printf ("🐏  %.2f\n GiB", $1 / 1024 / 1024)}')'';
      "power" = ''echo ⚡ $(upower -d | grep -m1 "energy-rate:" | tr -dc "(\.[0-9]+)?\b") W'';
      "gnome-wayland-debug" = "dbus-run-session -- gnome-shell --nested --wayland";
      "hotspot" = "sudo create_ap --daemon wlp0s20f3 enp0s20f0u1 vignesh-inspiron 12341234";
      "hotspot-list" = "sudo create_ap --list-clients ap0";
      "hotspot-stop" = "sudo create_ap --stop ap0";

      "dell-thermal-status" = "sudo cctk --ThermalManagement | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-thermal-cool" = "sudo cctk --ThermalManagement=Cool | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-thermal-quiet" = "sudo cctk --ThermalManagement=Quiet | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-thermal-optimized" = "sudo cctk --ThermalManagement=Optimized | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-thermal-ultra" = "sudo cctk --ThermalManagement=UltraPerformance | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";

      "dell-battery-status" = "sudo cctk --PrimaryBattChargeCfg | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-battery-standard" = "sudo cctk --PrimaryBattChargeCfg=Standard | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-battery-express" = "sudo cctk --PrimaryBattChargeCfg=Express | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
      "dell-battery-custom" = "sudo cctk --PrimaryBattChargeCfg=Custom:85-90 | sed '/^fopen_wrapper.c\\|^access_wrapper.c/d'";
    };
  };

  programs.htop = {
    enable = true;
    settings = {
      show_cpu_usage = 1;
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    };
  };
  
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
    '';
  };
}