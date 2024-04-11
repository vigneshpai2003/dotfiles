{ config, pkgs, ... }:
{
  # - Enable Virtualization
  boot.kernelModules = [ "kvm-intel" ];
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    kvmgt.enable = true;
    containers.enable = true;
  };
}
