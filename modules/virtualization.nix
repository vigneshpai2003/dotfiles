{ config, pkgs, ... }:
{
  # Use Virtualization
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.kvmgt.enable = true;
  virtualisation.containers.enable = true;
  virtualisation.waydroid.enable = true;

  services.openssh.enable = true;
}
