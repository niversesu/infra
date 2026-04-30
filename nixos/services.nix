{...}: {
  flake.nixosModules.services = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.mySystem.services.enable = lib.mkEnableOption "services";
    config = lib.mkIf config.mySystem.services.enable {
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
  };
}
