{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      mesa.drivers
    ];
  };
  
  environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
}
