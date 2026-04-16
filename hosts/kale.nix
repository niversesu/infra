{ self, ... }: {
  flake.nixosModules.host-kale = { config, pkgs, lib, ... }: {
    imports = [
      self.nixosModules.host-kale-hw
      self.nixosModules.configuration
      self.nixosModules.gnome
      self.nixosModules.keyd
      self.nixosModules.virt
      self.nixosModules.podman
      self.nixosModules.libvirt
      self.nixosModules.ydotool
      self.nixosModules.waydroid
    ];

    mySystem.virt.podman.enable = true;
    mySystem.virt.libvirt.enable = true;
    mySystem.virt.ydotool.enable = true;
    mySystem.virt.waydroid.enable = true;

    networking.hostName = "niver";
    users.users.niver = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];
    };
    services.getty.autologinUser = "niver";
  };
}
