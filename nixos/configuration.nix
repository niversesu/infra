{self, ...}: {
  flake.nixosModules.configuration = {
    imports = [
      ({
        config,
        pkgs,
        lib,
        ...
      }: {
        options.mySystem.configuration.enable = lib.mkEnableOption "configuration";
        config = lib.mkIf config.mySystem.configuration.enable {
          # Boot Configuration
          boot.loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
          hardware.enableRedistributableFirmware = true;
          # Bluetooth Configuration
          hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
          };
          services.blueman.enable = true;
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
              "https://nix-community.cachix.org"
              "https://niversesu.cachix.org"
            ];
            trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
              "niversesu.cachix.org-1:d/IqQ2LR79Cq4/iK3qmCgKe1mxUi8uPSKhkEjhI/SOc="
            ];
            auto-optimise-store = true;
          };
          boot.kernelPackages = pkgs.linuxPackages_latest;
          nixpkgs.config.allowUnfree = true;
          # Shell Integration
          security.sudo-rs.enable = true;
          environment.sessionVariables.XDG_DATA_DIRS = [
            "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
            "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
          ];
          programs.bash = {
            interactiveShellInit = ''
              if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
              then
                shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
                exec ${config.programs.fish.package}/bin/fish $LOGIN_OPTION
              fi
            '';
          };
          system.stateVersion = config.mySystem.shared.stateVersion;
        };
      })
    ];
  };
}
