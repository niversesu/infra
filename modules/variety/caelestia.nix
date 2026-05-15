{inputs, ...}: {
  flake.nixosModules.caelestia = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.caelestia.enable = lib.mkEnableOption "caelestia";
    config = lib.mkIf config.mySystem.caelestia.enable {
      mySystem.services.sddm = {
        enable = true;
        theme = "astronaut";
      };
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
      programs.gpu-screen-recorder.enable = true;
      services.geoclue2.enable = true;
      services.power-profiles-daemon.enable = true;
    };
  };
  flake.homeModules.caelestia = {
    config,
    lib,
    pkgs,
    osConfig,
    ...
  }: {
    imports = [
      inputs.caelestia-shell.homeManagerModules.default
    ];
    config = lib.mkIf (osConfig.mySystem.caelestia.enable or false) (lib.mkMerge [
      {
        programs.caelestia = {
          enable = true;
          systemd = {
            enable = true;
            target = "graphical-session.target";
          };
          settings = {
            general.idle.timeouts = {
              "600" = {
                idleAction = [];
              };
            };
            bar.status.showBattery = true;
            utilities = {
              enabled = true;
              maxToasts = 1;
              toasts.nowPlaying = true;
            };
            notifs = {
              expire = true;
              defaultExpireTimeout = 5000;
            };
            paths.wallpaperDir = "${config.home.homeDirectory}/Pictures/wallpapers";
          };
          cli = {
            enable = true;
            settings.theme.enableGtk = true;
          };
        };
        programs.foot.enable = true;
      }
      {
        home.packages = with pkgs;
          [
            nautilus
            loupe
            hyprsunset
            cliphist
          ]
          ++ [inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default];
      }
      {
        home.file = {
          ".config/hypr" = {
            source = "${inputs.caelestia-dotfiles}/hypr";
            recursive = true;
            force = true;
          };
          ".config/btop" = {
            source = "${inputs.caelestia-dotfiles}/btop";
            recursive = true;
            force = true;
          };
          ".config/foot" = {
            source = "${inputs.caelestia-dotfiles}/foot";
            recursive = true;
            force = true;
          };
        };
      }
    ]);
  };
}
