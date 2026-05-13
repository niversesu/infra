{inputs, ...}: {
  flake.nixosModules.caelestia = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.caelestia = {
      enable = lib.mkEnableOption "caelestia";
    };
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
      };
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
    config = lib.mkIf (osConfig.mySystem.caelestia.enable or false) {
      programs.caelestia = {
        enable = true;
        systemd = {
          enable = true;
          target = "graphical-session.target";
          environment = [];
        };
        settings = {
          bar.status = {
            showBattery = true;
          };
          idle = {
            lockBeforeSleep = false;
            inhibitWhenAudio = false;
            timeouts = [];
          };
          utilities = {
            enabled = true;
            maxToasts = 1;
          };
          paths.wallpaperDir = "${config.home.homeDirectory}/Pictures/wallpapers";
        };
        cli = {
          enable = true;
          settings = {
            theme.enableGtk = true;
          };
        };
      };
      programs.foot.enable = true;
      home.packages = with pkgs; [
        nautilus
        loupe
        hyprsunset
        cliphist
      ];
      home.file = let
        collectFiles = configDir: prefix: dir:
          lib.concatMapAttrs (
            name: type: let
              relPath =
                if prefix == ""
                then name
                else "${prefix}/${name}";
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
        collectFiles "hypr" "" "${dotfiles}/hypr"
        // collectFiles "btop" "" "${dotfiles}/btop"
        // collectFiles "foot" "" "${dotfiles}/foot";
    };
  };
}
