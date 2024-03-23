{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    libva-utils
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      mesa.drivers
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}
