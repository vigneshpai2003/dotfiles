{ config, pkgs, ... }:
{
  # - Enable Virtualization
  boot.kernelModules = [ "kvm-intel" ];
  virtualisation = {
    libvirtd.enable = true;
    kvmgt.enable = true;
    containers.enable = true;
  };
}
