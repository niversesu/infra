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
    ./environment.nix
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
    extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotoold" "libvirtd" ];
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
  system.stateVersion = "25.05";
  systemd.services.ydotoold = {
    description = "Ydotool Daemon";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    serviceConfig = {
      ExecStart = "${pkgs.ydotool}/bin/ydotoold \
        --socket-path=/run/ydotoold/ydotool_socket \
        --socket-perm=0666";
      Restart = "always";
      User = "root";
    };
  };

  environment.variables.YDOTOOL_SOCKET = "/run/ydotoold/ydotool_socket";
}
