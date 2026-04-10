{ self, ... }: {
  flake.nixosModules.host-nomi-hw = { config, lib, pkgs, modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" "sdhci_pci" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/0b3fbab4-a5df-4e80-b18d-f29e8837ebe3";
      fsType = "ext4";
    };
    fileSystems."/nix/store" = {
      device = "/nix/store";
      fsType = "none";
      options = [ "bind" ];
    };
    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/CA20-216D";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    swapDevices = [ ];
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
