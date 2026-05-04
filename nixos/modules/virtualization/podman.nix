{lib, ...}: {
  flake.nixosModules.podman = {config, pkgs, ...}: {
    options.mySystem.podman.enable = lib.mkEnableOption "podman";
    config = lib.mkIf config.mySystem.podman.enable {
      virtualisation.podman.enable = true;
      environment.systemPackages = with pkgs; [
        podman-compose
      ];
    };
  };
}
