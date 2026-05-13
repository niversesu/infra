{lib, ...}: {
  flake.nixosModules.libvirt = {
    config,
    pkgs,
    lib,
    ...
  }: {
    options.mySystem.libvirt.enable = lib.mkEnableOption "libvirt";

    config = lib.mkIf config.mySystem.libvirt.enable {
      programs.virt-manager.enable = true;
      virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [virtiofsd];
      };
    };
  };
}
