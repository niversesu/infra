{lib, ...}: {
  flake.nixosModules.podman = {config, ...}: {
    virtualisation.podman.enable = lib.mkIf config.mySystem.podman true;
  };
}
