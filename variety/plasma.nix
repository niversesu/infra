{ self, ... }: {
  flake.nixosModules.plasma = { config, pkgs, inputs, lib, ... }: {
    options.mySystem.plasma.enable = lib.mkEnableOption "plasma";

    config = lib.mkIf config.mySystem.plasma.enable {
      services.desktopManager.plasma6.enable = true;
      services.displayManager.plasma-login-manager = {
        enable = true;
      };
      programs.kdeconnect.enable = true;
    };
  };
}
