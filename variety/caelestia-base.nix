{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  options.mySystem.caelestia.enable = lib.mkEnableOption "caelestia";

  config = lib.mkIf config.mySystem.caelestia.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };
    services.geoclue2.enable = true;
    networking.networkmanager.enable = true;
    services.upower.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
