{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    libva-utils
    vulkan-tools
    clinfo
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      mesa.drivers
      intel-ocl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}
