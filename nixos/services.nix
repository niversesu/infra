{...}: {
  flake.nixosModules.services = {pkgs, ...}: {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    services = {
      upower.enable = true;
      openssh.enable = true;
      tailscale.enable = true;
    };
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
    xdg.portal.config.common.default = "*";
  };
}
