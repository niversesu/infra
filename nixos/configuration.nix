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

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Africa/Nairobi";
  i18n.defaultLocale = "en_US.UTF-8";

  programs.hyprland.enable = true;

  users.users.niver = {
    isNormalUser = true;
    description = "niver";
    extraGroups = ["networkmanager" "wheel" "input"];
    packages = with pkgs; [];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    keyd
  ];

  system.stateVersion = "25.05";
}

