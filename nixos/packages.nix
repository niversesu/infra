{...}: {
  flake.nixosModules.packages = {
    imports = [
      ({
        pkgs,
        lib,
        config,
        ...
      }: {
        options.mySystem.packages = lib.mkEnableOption "packages";
        config = lib.mkIf config.mySystem.packages {
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
          ];
        };
      })
    ];
  };
}
