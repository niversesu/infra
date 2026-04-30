{...}: {
  flake.nixosModules.host-kale-hw = {
    config,
    lib,
    ...
  }: {
    options.mySystem.host-kale-hw.enable = lib.mkEnableOption "host-kale-hw";
    config = lib.mkIf config.mySystem.host-kale-hw.enable {
      boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "sd_mod" "rtsx_pci_sdmmc"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = ["kvm-intel"];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/6fb9392f-e7a6-4ea1-8fa9-f522fcde8a17";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/A36E-A547";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };

      swapDevices = [{device = "/dev/disk/by-uuid/e5025781-af17-4081-b381-682f5480c7d5";}];

      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
