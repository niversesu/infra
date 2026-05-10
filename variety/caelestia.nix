{inputs, ...}: {
  flake.nixosModules.caelestia = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.caelestia = {
      enable = lib.mkEnableOption "caelestia";
    };
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
  };

  flake.homeModules.caelestia = {
    config,
    lib,
    pkgs,
    osConfig,
    ...
  }: {
    imports = [
      inputs.caelestia-shell.homeManagerModules.default
    ];

    config = lib.mkIf (osConfig.mySystem.caelestia.enable or false) {
      programs.caelestia = {
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
      programs.kitty.enable = true;
      home.packages = with pkgs; [
        kdePackages.dolphin
      ];
    };
  };
}
