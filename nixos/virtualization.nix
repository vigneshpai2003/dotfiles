{ config, pkgs, ... }:
{
  # Use Virtualization
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation = {
    libvirtd.enable = true;
    kvmgt.enable = true;
    containers.enable = true;
    waydroid.enable = true;
    podman.enable = true;
    podman.dockerCompat = true;
  };

  services.openssh.enable = true;
}
