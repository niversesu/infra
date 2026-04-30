{lib, ...}: {
  flake.nixosModules.waydroid = {config, ...}: {
    virtualisation.waydroid.enable = lib.mkIf config.mySystem.waydroid true;
  };
}
