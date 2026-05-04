{
  self,
  lib,
  ...
}: {
  flake.nixosModules.shared = {
    config,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.host-kale-hw
      self.nixosModules.host-nomi-hw

      self.nixosModules.configuration
      self.nixosModules.packages
      self.nixosModules.services

      self.nixosModules.gnome
      self.nixosModules.plasma
      self.nixosModules.illogical

      self.nixosModules.keyd

      self.nixosModules.podman
      self.nixosModules.libvirt
      self.nixosModules.ydotool
      self.nixosModules.waydroid
      self.nixosModules.nix-flatpak
    ];
    options.mySystem.shared.enable = lib.mkEnableOption "shared";
    config = lib.mkIf config.mySystem.shared.enable {
      mySystem.host-kale-hw.enable = lib.mkDefault false;
      mySystem.host-nomi-hw.enable = lib.mkDefault false;
      mySystem.configuration.enable = lib.mkDefault true;
      mySystem.packages.enable = lib.mkDefault true;
      mySystem.services.enable = lib.mkDefault true;
      mySystem.gnome.enable = lib.mkDefault true;
      mySystem.plasma.enable = lib.mkDefault false;
      mySystem.illogical.enable = lib.mkDefault false;
      mySystem.keyd.enable = lib.mkDefault false;
      mySystem.podman.enable = lib.mkDefault false;
      mySystem.libvirt.enable = lib.mkDefault false;
      mySystem.ydotool.enable = lib.mkDefault false;
      mySystem.waydroid.enable = lib.mkDefault true;
      mySystem.nix-flatpak.enable = lib.mkDefault true;

      networking.hostName = "${config.mySystem.host}";
      users.users.${config.mySystem.user} = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];
      };
      services.getty.autologinUser = config.mySystem.user;
    };
  };

  flake.homeModules.shared = {
    config,
    lib,
    osConfig,
    ...
  }: {
    imports = [
      self.homeModules.nixvim
      self.homeModules.fish
      self.homeModules.theming
      self.homeModules.starship
      self.homeModules.git
      self.homeModules.vscode
      self.homeModules.illogical
      self.homeModules.spicetify
      self.homeModules.packages
    ];
    config = lib.mkIf osConfig.mySystem.shared.enable {
      nixpkgs.config.allowUnfree = true;
      home = {
        username = osConfig.mySystem.user;
        homeDirectory = "/home/${osConfig.mySystem.user}";
        stateVersion = "26.05";
      };

    };
  };
  options.mySystem = {
    host = lib.mkOption {
      type = lib.types.str;
      default = "kale";
    };
    user = lib.mkOption {
      type = lib.types.str;
      default = "niver";
    };
  };
}
