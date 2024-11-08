{ pkgs, ... }:
{
  # - Sound
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # - Power Management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  services = {
    thermald.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
  };

  # - Intel iGPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
      vaapiVdpau
      mesa.drivers
    ];
  };

  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
}
