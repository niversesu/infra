{...}: {
  flake.nixosModules.services = {pkgs, ...}: {
    services = {
      #flatpak.enable = true;
      upower.enable = true;
      openssh.enable = true;
      tailscale.enable = true;
    };
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdg.portal.config.common.default = "*";
  };
}
