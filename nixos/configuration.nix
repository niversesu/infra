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

  # Create directories with full permissions
  systemd = {
    tmpfiles.settings = {
      "docker_folders" = {
        "${config.users.users.niver.home}/yeat_1" = {d.mode = "0777";};
        "${config.users.users.niver.home}/yeat_2" = {d.mode = "0777";};
        "${config.users.users.niver.home}/yeat_3" = {d.mode = "0777";};
      };
    };
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

