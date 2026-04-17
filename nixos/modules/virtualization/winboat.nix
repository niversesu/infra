{ pkgs, config, lib, ... }@args: {
  config = lib.mkIf (config.mySystem.virt.winboat or false) {
    virtualisation.docker.enable = true;
    environment.systemPackages = [ pkgs.winboat ];
  };
}