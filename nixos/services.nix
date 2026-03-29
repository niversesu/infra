{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./modules/keyd.nix];

  services = {
    getty.autologinUser = "niver";
    flatpak.enable = true;
    upower.enable = true;
    openssh.enable = true;
    tailscale.enable = true;
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

  programs = {
    virt-manager.enable = true;
    ydotool.enable = true;
  };
  environment.variables.YDOTOOL_SOCKET = lib.mkForce "/run/user/1000/.ydotool_socket";

  virtualisation = {
    waydroid.enable = true;
    podman.enable = true;
    docker.enable = false;
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [virtiofsd];
    };
  };
  networking.nftables.enable = false;
}
