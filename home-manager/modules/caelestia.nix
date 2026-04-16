{ self, inputs, ... }: {
  flake.homeModules.caelestia = { config, pkgs, lib, osConfig, ... }: {
    imports = [
      inputs.caelestia-shell.homeManagerModules.default
    ];

    programs.kitty.enable = lib.mkIf (osConfig.mySystem.caelestia.enable or false) true;

    programs.caelestia = lib.mkIf (osConfig.mySystem.caelestia.enable or false) {
      enable = true;
      systemd = {
        enable = true;
        target = "graphical-session.target";
        environment = [];
      };
      settings = {
        bar.status = {
          showBattery = true;
        };
        paths.wallpaperDir = "~/Pictures/wallpapers";
      };
      cli = {
        enable = true;
        settings = {
          theme.enableGtk = true;
        };
      };
    };

    home.packages = lib.mkIf (osConfig.mySystem.caelestia.enable or false) (with pkgs; [
      kdePackages.dolphin
    ]);
  };
}
