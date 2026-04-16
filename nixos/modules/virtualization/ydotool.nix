{ lib, ... }: {
  flake.nixosModules.ydotool = { config, ... }: {
    programs.ydotool.enable = lib.mkIf config.mySystem.virt.ydotool.enable true;
    environment.variables.YDOTOOL_SOCKET = lib.mkIf config.mySystem.virt.ydotool.enable
      (lib.mkForce "/run/user/1000/.ydotool_socket");
  };
}
