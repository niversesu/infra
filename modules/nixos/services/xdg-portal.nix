{...}: {
  flake.nixosModules.xdg-portal = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.services.xdg-portal.enable = lib.mkEnableOption "XDG Desktop Portal" // {default = true;};

    config = lib.mkIf config.mySystem.services.xdg-portal.enable {
      xdg.portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-gtk];
        config.common.default = "*";
      };
    };
  };
}
