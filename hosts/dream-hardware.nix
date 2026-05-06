{...}: {
  flake.nixosModules.host-dream-hw = {
    config,
    lib,
    ...
  }: {
    options.mySystem.host-dream-hw.enable = lib.mkEnableOption "host-dream-hw";
    config = lib.mkIf config.mySystem.host-dream-hw.enable {
      boot.initrd.availableKernelModules = ["xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
      boot.initrd.kernelModules = [];
      boot.kernelModules = [];
      boot.extraModulePackages = [];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/8004710c-98cb-4984-bf43-10cf69f8344f";
        fsType = "ext4";
      };

      swapDevices = [];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  };
}
