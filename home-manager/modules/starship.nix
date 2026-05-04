{...}: {
  flake.homeModules.starship = {
    config,
    lib,
    ...
  }: {
    options.myHome.starship.enable = lib.mkEnableOption "starship";
    config = lib.mkIf config.myHome.starship.enable {
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        enableInteractive = true;
      };
    };
  };
}
