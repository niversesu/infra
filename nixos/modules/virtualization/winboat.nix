{ lib, config, pkgs, ... }: {
  options.mySystem.virt.winboat = lib.mkEnableOption "winboat";

  config = lib.mkIf config.mySystem.virt.winboat {
    virtualisation.docker.enable = true;
    environment.systemPackages = [ pkgs.freerdp3 ];
  };
}