{
  config,
  pkgs,
  lib,
  ...
}: {
  options.mySystem.illogical.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.mySystem.gnome.enable {
    #imports = [ ./dconf.nix ];
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = with pkgs; [epiphany];
    environment.systemPackages = with pkgs; [
      gnomeExtensions.appindicator
      gnomeExtensions.copyous
      gnomeExtensions.blur-my-shell
    ];
    programs.kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };
}
