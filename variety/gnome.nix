{...}: {
  flake.nixosModules.gnome = {
    imports = [
      ({pkgs, lib, config, ...}: {
        options.mySystem.gnome.enable = lib.mkEnableOption "gnome";

        config = lib.mkIf config.mySystem.gnome.enable {
          services = {
            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;
            gnome.gnome-remote-desktop.enable = true;

            xrdp.enable = true;
            xrdp.defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
            xrdp.openFirewall = true;
          };

          environment.gnome.excludePackages = with pkgs; [epiphany];
          environment.systemPackages = with pkgs; [
            gnomeExtensions.appindicator
            gnomeExtensions.copyous
            gnomeExtensions.blur-my-shell
            gnomeExtensions.kiwi-is-not-apple
            gnomeExtensions.kiwi-menu
            gnome-remote-desktop
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
