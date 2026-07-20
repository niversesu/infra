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
        gtk2.force = true;
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
          package = pkgs.dracula-theme;
          name = "Dracula";
        };
      };

      xdg.configFile."gtk-3.0/settings.ini".force = true;
      xdg.configFile."gtk-4.0/settings.ini".force = true;

      qt = {
        enable = true;
        platformTheme.name = "gtk3";
        style = {
          name = "adwaita-dark";
          package = pkgs.adwaita-qt;
        };
      };
    };
  };
}
