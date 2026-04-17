{ lib, config, pkgs, ... }: {
  config = lib.mkIf config.mySystem.virt.winboat {
    virtualisation.docker.enable = true;
    environment.systemPackages = [ pkgs.winboat ];
  };
}