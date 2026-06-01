{...}: {
  flake.nixosModules.core-hardware = {
    config,
    lib,
    ...
  }: {
    options.mySystem.core.hardware.enable = lib.mkEnableOption "Core Hardware Integration (Bluetooth, Zram)";
    config = lib.mkIf config.mySystem.core.hardware.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      services.blueman.enable = true;
      zramSwap = {
        enable = true;
        memoryPercent = 100;
      };
      services.upower.enable = true;
    };
  };
}
