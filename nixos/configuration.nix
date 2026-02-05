#tuff?
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services.nix
    ./packages.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap.enable = true;
  zramSwap.memoryPercent = 100;
 # swapDevices = [{
 #   device = "/dev/disk/by-uuid/e5025781-af17-4081-b381-682f5480c7d5";
 # }];
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Nairobi";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.niver = {
    isNormalUser = true;
    description = "niver";
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd"];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
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

}
