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
            fd
            gparted
            alejandra
            unzip
            aria2
            eza
            wget
            mpv
            curl
            home-manager
            nh
            nix-output-monitor
            nvd
            zoxide
            fzf
            nix-index
            comma
            yazi
            bat
            fd
            tealdeer
            du-dust
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
