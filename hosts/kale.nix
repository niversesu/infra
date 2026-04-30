{self, ...}: {
  flake.nixosModules.host-kale = {...}: {
    imports = [
      self.nixosModules.host-kale-hw

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

    mySystem.host-kale-hw.enable = true;

    mySystem.configuration.enable = true;
    mySystem.packages = true;
    mySystem.services.enable = true;

    mySystem.gnome.enable = true;
    mySystem.plasma.enable = false;
    mySystem.illogical.enable = false;

    mySystem.keyd.enable = true;

    mySystem.podman = true;
    mySystem.libvirt = true;
    mySystem.ydotool = true;
    mySystem.waydroid = true;
    mySystem.nix-flatpak.enable = true;

    networking.hostName = "niver";
    users.users.niver = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman" "docker"];
    };
    services.getty.autologinUser = "niver";
  };
}
