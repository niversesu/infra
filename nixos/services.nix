{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [./modules/keyd.nix];

  services = {
    xserver.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    getty.autologinUser = "niver";
    flatpak.enable = true;
    upower.enable = true;
    openssh.enable = true;
    tailscale.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [epiphany];

  programs = {
    virt-manager.enable = true;
    ydotool.enable = true;
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
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
