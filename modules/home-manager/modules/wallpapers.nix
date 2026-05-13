{inputs, ...}: {
  flake.homeModules.wallpapers = {
    config,
    lib,
    ...
  }: {
    options.myHome.wallpapers = {
      enable = lib.mkEnableOption "wallpapers";
    };

    config = lib.mkIf config.myHome.wallpapers.enable {
      home.file."Pictures/wallpapers" = {
        source = inputs.wallpapers;
        recursive = true;
      };
    };
  };
}
