{...}: {
  flake.nixosModules.libvirt = {
    config,
    pkgs,
    lib,
    ...
  }: {
    programs.virt-manager.enable = lib.mkIf config.mySystem.libvirt true;
    virtualisation.libvirtd = lib.mkIf config.mySystem.libvirt {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
  };
}
