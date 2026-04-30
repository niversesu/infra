{self, ...}: {
  flake.nixosModules.host-nomi = {...}: {
    imports = [
      self.nixosModules.host-nomi-hw

      self.nixosModules.configuration
      self.nixosModules.packages
      self.nixosModules.services

      self.nixosModules.gnome
      self.nixosModules.plasma
      self.nixosModules.illogical

      self.nixosModules.keyd

      self.nixosModules.virt
      self.nixosModules.podman
      self.nixosModules.libvirt
      self.nixosModules.ydotool
      self.nixosModules.waydroid
      self.nixosModules.nix-flatpak
    ];

    mySystem.host-nomi-hw.enable = true;

    mySystem.configuration.enable = true;
    mySystem.packages = true;
    mySystem.services.enable = true;

    mySystem.gnome.enable = true;
    mySystem.plasma.enable = true;
    mySystem.illogical.enable = true;

    mySystem.keyd.enable = false;

    mySystem.podman = false;
    mySystem.libvirt = false;
    mySystem.ydotool = false;
    mySystem.waydroid = true;
    mySystem.nix-flatpak.enable = false;

    networking.hostName = "faith";
    users.users.faith = {
      isNormalUser = true;
      description = "faith";
      extraGroups = ["networkmanager" "wheel" "input" "uinput" "podman" "docker"];
    };
    services.getty.autologinUser = "faith";
  };
}
