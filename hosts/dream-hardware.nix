{...}: {
  flake.nixosModules.host-dream-hw = {
    config,
    lib,
    ...
  }: {
    options.mySystem.host-dream-hw.enable = lib.mkEnableOption "host-dream-hw";
    config = lib.mkIf config.mySystem.host-dream-hw.enable {
      # TODO: Configure hardware-specific settings for dream
      # boot.initrd.availableKernelModules = [];
      # boot.kernelModules = [];
      # fileSystems."/" = { ... };
      # fileSystems."/boot" = { ... };
      # swapDevices = [];

      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
  };
}
