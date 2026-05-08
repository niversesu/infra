{...}: {
  flake.nixosModules.packages = {
    imports = [
      ({
        pkgs,
        lib,
        config,
        ...
      }: {
        options.mySystem.packages.enable = lib.mkEnableOption "packages";
        config = lib.mkIf config.mySystem.packages.enable {
          environment.systemPackages = with pkgs; [
            fastfetch
            ripgrep
            gparted
            alejandra
            unzip
            aria2
            eza
            wget
            mpv
            curl
            home-manager
            wl-clipboard
            cpx
            cachix
            waypipe
          ];
        };
      })
    ];
  };
}
