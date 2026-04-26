{...}: {
  flake.homeModules.theming = {
    config,
    pkgs,
    lib,
    ...
  }: {
    options.myHome.theming = {
      enable = lib.mkEnableOption "theming";
      cursorName = lib.mkOption {
        type = lib.types.str;
        default = "Bibata-Modern-Ice";
      };
    };

    config = lib.mkIf config.myHome.theming.enable {
      gtk = {
        enable = true;
        cursorTheme = {
          package = pkgs.bibata-cursors;
          name = config.myHome.theming.cursorName;
          size = 24;
        };
        iconTheme = {
          package = pkgs.dracula-icon-theme;
          name = "Dracula";
        };
        theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
        };
      };
    };
  };
}
