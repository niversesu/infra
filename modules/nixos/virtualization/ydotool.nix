{lib, ...}: {
  flake.nixosModules.ydotool = {config, ...}: {
    options.mySystem.ydotool.enable = lib.mkEnableOption "ydotool";
    config = lib.mkIf config.mySystem.ydotool.enable {
      programs.ydotool.enable = true;
      #environment.variables.YDOTOOL_SOCKET =
      #lib.mkForce "/run/user/1000/.ydotool_socket";
    };
  };
}
