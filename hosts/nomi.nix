{ self, ... }: {
  flake.nixosModules.host-nomi = { config, pkgs, lib, ... }: {
    imports = [
      self.nixosModules.host-nomi-hw
      self.nixosModules.configuration
      self.nixosModules.illogical-base
      # self.nixosModules.caelestia-base
      self.nixosModules.plasma
      self.nixosModules.gnome
    ];
    networking.hostName = "faith";
    users.users.faith = {
      isNormalUser = true;
      description = "faith";
      extraGroups = ["networkmanager" "wheel" "input" "uinput" "podman"];
    };
    services.getty.autologinUser = "faith";
  };
}
