{inputs, ...}: {
  flake.nixosModules.caelestia = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.caelestia.enable = lib.mkEnableOption "caelestia";
    config = lib.mkIf config.mySystem.caelestia.enable {
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
      services.geoclue2.enable = true;
      services.power-profiles-daemon.enable = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "sddm-astronaut-theme";
        extraPackages = with pkgs; [
          kdePackages.qtmultimedia
          gst_all_1.gstreamer
          gst_all_1.gst-plugins-base
          gst_all_1.gst-libav
        ];
      };
      environment.systemPackages = [
        (pkgs.sddm-astronaut.override {
          embeddedTheme = "hyprland_kath";
        })
      ];
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
          general.idle.timeouts = {
            "600" = {
              idleAction = [ ];
            };
          };
          settings = {
            bar.status.showBattery = true;
          };
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
          cli = {
            enable = true;
            settings.theme.enableGtk = true;
          };
        };
        programs.foot.enable = true;
      }
      {
        home.packages = with pkgs; [
          nautilus
          loupe
          hyprsunset
          cliphist
        ] ++ [inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default];
      }
      {
        home.file = let
          collectFiles = configDir: prefix: dir:
            lib.concatMapAttrs (
              name: type: let
                relPath = if prefix == "" then name else "${prefix}/${name}";
                absPath = "${dir}/${name}";
              in
                if type == "regular"
                then {".config/${configDir}/${relPath}".source = absPath;}
                else if type == "directory"
                then collectFiles configDir relPath absPath
                else {}
            ) (builtins.readDir dir);
          dotfiles = inputs.caelestia-dotfiles;
        in
          lib.mkMerge [
            (collectFiles "hypr" "" "${dotfiles}/hypr")
            (collectFiles "btop" "" "${dotfiles}/btop")
            (collectFiles "foot" "" "${dotfiles}/foot")
          ];
      }
    ]);
  };
}
