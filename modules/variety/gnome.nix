{...}: {
  flake.nixosModules.gnome = {
    imports = [
      ({
        pkgs,
        lib,
        config,
        ...
      }: {
        options.mySystem.gnome.enable = lib.mkEnableOption "gnome";

        config = lib.mkIf config.mySystem.gnome.enable {
          services = {
            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;
          };

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
      })
    ];
  };
}
