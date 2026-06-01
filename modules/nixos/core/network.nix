{...}: {
  flake.nixosModules.core-network = {
    config,
    lib,
    ...
  }: {
    options.mySystem.core.network.enable = lib.mkEnableOption "Core Network Configuration";
    config = lib.mkIf config.mySystem.core.network.enable {
      networking.networkmanager.enable = true;
      services.openssh.enable = true;
      services.tailscale.enable = true;
    };
  };
}
