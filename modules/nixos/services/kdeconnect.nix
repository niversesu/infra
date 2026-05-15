{ inputs, self, ... }: {
  flake.nixosModules.kdeconnect = { config, lib, ... }: {
    options.mySystem.services.kdeconnect = {
      enable = lib.mkEnableOption "KDE Connect";
      hypr-fix = lib.mkOption {
        type = lib.types.bool;
        default = config.mySystem.caelestia.enable or false;
        description = "Enable hypr-kdeconnect-fix portal bridge";
      };
    };

    imports = [ inputs.hypr-kdeconnect-nix.nixosModules.default ];

    config = lib.mkIf config.mySystem.services.kdeconnect.enable {
      programs.kdeconnect.enable = true;
      services.hypr-kdeconnect-fix.enable = config.mySystem.services.kdeconnect.hypr-fix;
    };
  };

  flake.homeModules.kdeconnect = { config, lib, osConfig, ... }: {
    imports = [ inputs.hypr-kdeconnect-nix.homeManagerModules.default ];
    config = lib.mkIf (osConfig.mySystem.services.kdeconnect.enable or false) {
      services.hypr-kdeconnect-fix = {
        enable = osConfig.mySystem.services.kdeconnect.hypr-fix;
        compositor = if osConfig.mySystem.caelestia.enable then "hyprland" else "generic";
      };
    };
  };
}
