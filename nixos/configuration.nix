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

  # User Configuration
  users.users.niver = {
    isNormalUser = true;
    description = "niver";
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];};

  # Nix Configuration
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Shell Integration
  programs.bash.interactiveShellInit = ''
    # Only start Fish if parent isn't Fish and not a single-command bash
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z "$BASH_EXECUTION_STRING" ]]; then
      shopt -q login_shell && LOGIN_OPTION="--login" || LOGIN_OPTION=""
      # Use Home Manager's Fish from the user's profile
      if [ -x "$HOME/.nix-profile/bin/fish" ]; then
        exec "$HOME/.nix-profile/bin/fish" $LOGIN_OPTION
      fi
    fi
  '';

  system.stateVersion = "25.05";
}
