{...}: {
  flake.nixosModules.core-boot = {
    config,
    lib,
    ...
  }: {
    options.mySystem.core.boot.enable = lib.mkEnableOption "Core Bootloader (Systemd-boot)";
    config = lib.mkIf config.mySystem.core.boot.enable {
      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      hardware.enableRedistributableFirmware = true;
    };
  };
}
