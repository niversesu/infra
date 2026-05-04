{lib, ...}: {
  flake.nixosModules.waydroid = {config, lib, ...}: {
    options.mySystem.waydroid.enable = lib.mkEnableOption "waydroid";
    config = lib.mkIf config.mySystem.waydroid.enable {
      virtualisation.waydroid.enable = true;
    };
  };
}
