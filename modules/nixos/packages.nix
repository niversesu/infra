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
            dust
            wl-clipboard
            cpx
            cachix
            waypipe
            (mpv.override {
              scripts = [
                mpvScripts.uosc
                mpvScripts.sponsorblock
              ];
            })
          ];
        };
      })
    ];
  };
}
