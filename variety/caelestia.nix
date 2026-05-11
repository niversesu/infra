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
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };
      services.geoclue2.enable = true;
      networking.networkmanager.enable = true;
      services.upower.enable = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      hjem.users.${config.mySystem.shared.user} = {
        enable = true;
        directory = "/home/${config.mySystem.shared.user}";
        files = let
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
          paths.wallpaperDir = "~/Pictures/wallpapers";
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
        hyprsunset
        cliphist
      ];
    };
  };
}
