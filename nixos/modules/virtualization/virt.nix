{ lib, ... }: {
  flake.nixosModules.virt = { ... }: {
    options.mySystem.virt = {
      waydroid.enable  = lib.mkEnableOption "waydroid";
      podman.enable    = lib.mkEnableOption "podman";
      libvirt.enable   = lib.mkEnableOption "libvirt and virt-manager";
      ydotool.enable   = lib.mkEnableOption "ydotool";
      winboat.enable   = lib.mkEnableOption "winboat";
    };

    config = {
      networking.nftables.enable = false;
    };
  };
}
