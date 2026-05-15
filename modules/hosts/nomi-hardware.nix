{...}: {
  flake.nixosModules.host-nomi-hw = {
    config,
    lib,
    ...
  }: {
    options.mySystem.host-nomi-hw.enable = lib.mkEnableOption "host-nomi-hw";
    config = lib.mkIf config.mySystem.host-nomi-hw.enable {
      boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" "sdhci_pci"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-intel"];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/sda3";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/CA20-216D";
        fsType = "vfat";
        options = ["fmask=0022" "dmask=0022"];
      };

      swapDevices = [];
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
