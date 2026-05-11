{
  self,
  lib,
  ...
}: {
  flake.nixosModules.shared = {
    config,
    lib,
    inputs,
    ...
  }: {
    imports = [
      inputs.hjem.nixosModules.default
      self.nixosModules.host-kale-hw
      self.nixosModules.host-nomi-hw
      self.nixosModules.host-dream-hw

      self.nixosModules.configuration
      self.nixosModules.packages
      self.nixosModules.services

      self.nixosModules.gnome
      self.nixosModules.plasma
      self.nixosModules.illogical
      self.nixosModules.caelestia

      self.nixosModules.keyd

      self.nixosModules.podman
      self.nixosModules.libvirt
      self.nixosModules.ydotool
      self.nixosModules.waydroid
      self.nixosModules.nix-flatpak
      self.nixosModules.obs-studio
    ];
    options.mySystem.shared = {
      enable = lib.mkEnableOption "shared";
      host = lib.mkOption {
        type = lib.types.str;
        default = "kale";
      };
      user = lib.mkOption {
        type = lib.types.str;
        default = "kale";
      };
    };
    config = lib.mkIf config.mySystem.shared.enable {
      mySystem.configuration.enable = lib.mkDefault true;
      mySystem.packages.enable = lib.mkDefault true;
      mySystem.services.enable = lib.mkDefault true;
      mySystem.gnome.enable = lib.mkDefault true;
      mySystem.waydroid.enable = lib.mkDefault true;
      mySystem.nix-flatpak.enable = lib.mkDefault true;
      mySystem.obs-studio.enable = lib.mkDefault true;
      networking.hostName = "${config.mySystem.shared.host}";
      users.users.${config.mySystem.shared.user} = {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];
      };
      services.getty.autologinUser = config.mySystem.shared.user;
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
      self.homeModules.caelestia
      self.homeModules.spicetify
      self.homeModules.packages
    ];
    config = lib.mkIf osConfig.mySystem.shared.enable {
      myHome.fish.enable = lib.mkDefault false;
      myHome.git.enable = lib.mkDefault true;
      myHome.nixvim.enable = lib.mkDefault true;
      myHome.packages.enable = lib.mkDefault true;
      myHome.spicetify.enable = lib.mkDefault true;
      myHome.starship.enable = lib.mkDefault true;
      myHome.theming.enable = lib.mkDefault false;
      myHome.vscode.enable = lib.mkDefault true;
      nixpkgs.config.allowUnfree = true;
      home = {
        username = osConfig.mySystem.shared.user;
        homeDirectory = "/home/${osConfig.mySystem.shared.user}";
        stateVersion = "26.05";
      };
    };
  };
}
