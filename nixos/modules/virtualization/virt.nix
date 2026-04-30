{lib, ...}: {
  flake.nixosModules.virt = {...}: {
    options = {
      mySystem.podman = lib.mkEnableOption "podman";
      mySystem.libvirt = lib.mkEnableOption "libvirt and virt-manager";
      mySystem.ydotool = lib.mkEnableOption "ydotool";
      mySystem.waydroid = lib.mkEnableOption "waydroid";
    };

    config = {
      networking.nftables.enable = false;
    };
  };
}
