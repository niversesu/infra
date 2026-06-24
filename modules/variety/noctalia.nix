{inputs, ...}: {
  flake.nixosModules.noctalia = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.noctalia.enable = lib.mkEnableOption "noctalia";
    config = lib.mkIf config.mySystem.noctalia.enable {
      mySystem.services.sddm = {
        enable = true;
        theme = "astronaut";
        video = "sukuna";
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
  flake.homeModules.noctalia = {
    config,
    lib,
    pkgs,
    osConfig,
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];
    config = lib.mkIf (osConfig.mySystem.noctalia.enable or false) (lib.mkMerge [
      {
        programs.noctalia = {
          enable = true;
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
            source = "${inputs.noctalia-dotfiles}/hypr";
            recursive = true;
            force = true;
          };

          ".config/foot" = {
            source = "${inputs.noctalia-dotfiles}/foot";
            recursive = true;
            force = true;
          };
        };
      }
    ]);
  };
}
