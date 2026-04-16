{ ... }: {
  flake.nixosModules.libvirt = { config, pkgs, lib, ... }: {
    programs.virt-manager.enable = lib.mkIf config.mySystem.virt.libvirt.enable true;
    virtualisation.libvirtd = lib.mkIf config.mySystem.virt.libvirt.enable {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
  };
}
