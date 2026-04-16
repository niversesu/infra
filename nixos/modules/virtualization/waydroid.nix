{ lib, ... }: {
  flake.nixosModules.waydroid = { config, ... }: {
    virtualisation.waydroid.enable = lib.mkIf config.mySystem.virt.waydroid.enable true;
  };
}
