{ ... }: {
  flake.nixosModules.virt-ydot = { config, pkgs, lib, ... }: {
    options.mySystem.virt-ydot = {
      waydroid.enable  = lib.mkEnableOption "waydroid";
      podman.enable    = lib.mkEnableOption "podman";
      libvirt.enable   = lib.mkEnableOption "libvirt and virt-manager";
      ydotool.enable   = lib.mkEnableOption "ydotool";
    };

    config = {
      virtualisation.waydroid.enable = lib.mkIf config.mySystem.virt-ydot.waydroid.enable true;

      virtualisation.podman.enable = lib.mkIf config.mySystem.virt-ydot.podman.enable true;

      programs.virt-manager.enable = lib.mkIf config.mySystem.virt-ydot.libvirt.enable true;
      virtualisation.libvirtd = lib.mkIf config.mySystem.virt-ydot.libvirt.enable {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [virtiofsd];
      };

      programs.ydotool.enable = lib.mkIf config.mySystem.virt-ydot.ydotool.enable true;
      environment.variables.YDOTOOL_SOCKET = lib.mkIf config.mySystem.virt-ydot.ydotool.enable
        (lib.mkForce "/run/user/1000/.ydotool_socket");

      networking.nftables.enable = false;
    };
  };
}
