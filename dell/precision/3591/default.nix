{ lib, ... }:

{
  imports = [
    ../../../common/cpu/intel
    ../../../common/pc/laptop
    ../../../common/pc/ssd
    #../../../common/gpu/nvidia
    #../../../common/gpu/nvidia/disable.nix
  ];

  # Boot loader
  boot.kernelParams = [
    # fix flicker
    # source https://wiki.archlinux.org/index.php/Intel_graphics#Screen_flickering
    # See https://discourse.nixos.org/t/i915-driver-has-bug-for-iris-xe-graphics/25006/12
    # jheidbrink reports that without this setting there is a very high lag in Sway which makes it unusable
    "i915.enable_psr=0"
  ];

  #boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];

  boot = {
    kernelModules = ["kvm-intel"];
    blacklistedKernelModules = ["nouveau"];
  };

  # Recommended in NixOS/nixos-hardware#127
  services.thermald.enable = lib.mkDefault true;

  # available cpufreq governors: performance powersave
  # The powersave mode locks the cpu to a 900mhz frequency which is not ideal
  #powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # Make the webcam work (needs Linux >= 6.6):
  #hardware.ipu6.enable = true;
  #hardware.ipu6.platform = "ipu6ep";
}
