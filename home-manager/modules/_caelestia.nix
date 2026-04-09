{
  config,
  inputs,
  pkgs,
  caelestia-shell,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf (osConfig.mySystem.caelestia.enable or false) {
    programs.kitty.enable = true;
    programs.caelestia-shell = {
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
    home.packages = with pkgs; [
      kdePackages.dolphin
    ];
  };
}
