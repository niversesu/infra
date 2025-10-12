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
    #./chrome-remote-desktop/chrome-remote-desktop.nix
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
    extraGroups = ["networkmanager" "wheel" "input" "uinput"];
    packages = with pkgs; [];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Chrome Remote Desktop overlay
#  nixpkgs.overlays = [
#    (self: super: {
#      chrome-remote-desktop = super.callPackage ./chrome-remote-desktop/default.nix {};
#    })
#  ];

  system.stateVersion = "25.05";
}

