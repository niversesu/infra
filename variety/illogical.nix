{ inputs, ... }: {
  flake.nixosModules.illogical = { config, pkgs, lib, ... }: {
    options.mySystem.illogical.enable = lib.mkEnableOption "illogical impulse";

    config = lib.mkIf config.mySystem.illogical.enable {
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
      environment.systemPackages = with pkgs; [
        qt5.qtgraphicaleffects
        qt6.qt5compat
        qt6.qtpositioning
        kdePackages.syntax-highlighting
      ];
    };
  };

  flake.homeModules.illogical = { pkgs, lib, osConfig, ... }: {
    imports = [
      inputs.illogical-flake.homeManagerModules.default
    ];
    config = lib.mkIf (osConfig.mySystem.illogical.enable or false) {
      programs.illogical-impulse = {
        enable = true;
        dotfiles = {
          fish.enable = true;
          kitty.enable = true;
          starship.enable = true;
        };
        hyprland.plugins = [
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
        ];
      };
      home.packages = with pkgs; [
        kdePackages.dolphin
      ];
    };
  };
}
