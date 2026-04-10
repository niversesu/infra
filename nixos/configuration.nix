{ self, ... }: {
  flake.nixosModules.configuration = {
    imports = [
      ({ config, pkgs, ... }: {
        imports = [
          self.nixosModules.services
          self.nixosModules.packages
          self.nixosModules.obs
        ];
        # Boot Configuration
        boot.loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        # Memory Management
        zramSwap = {
          enable = true;
          memoryPercent = 100;
        };
        # Network Configuration
        networking = {
          networkmanager.enable = true;
        };
        # Time & Locale
        time.timeZone = "Africa/Nairobi";
        i18n.defaultLocale = "en_US.UTF-8";
        # Nix Configuration
        nix.settings = {
          experimental-features = ["nix-command" "flakes"];
          trusted-users = ["root" "faith" "niver"];
          substituters = [    
          "https://cache.nixos.org"
          "https://hyprland.cachix.org"
          ];
          trusted-public-keys = [    
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          ];
          post-build-hook = pkgs.writeShellScript "cachix-push" ''
            set -euf
            export HOME=/root
            exec ${pkgs.cachix}/bin/cachix push niversesu $OUT_PATHS
          '';
        };
        boot.kernelPackages = pkgs.linuxPackages_zen;
        nixpkgs.config.allowUnfree = true;
        # Shell Integration
        programs.bash = {
          interactiveShellInit = ''
            if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
            then
              shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
              exec ${config.programs.fish.package}/bin/fish $LOGIN_OPTION
            fi
          '';
        };
        system.stateVersion = "26.05";
      })
    ];
  };
}
