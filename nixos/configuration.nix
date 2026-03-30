{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./packages.nix
    ./modules/obs.nix
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
  nix.settings.experimental-features = ["nix-command" "flakes"];
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
}
