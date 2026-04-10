{ self, ... }: {
  flake.nixosModules.host-kale = { config, pkgs, lib, ... }: {
    imports = [
      self.nixosModules.host-kale-hw
      self.nixosModules.configuration
      # self.nixosModules.illogical-base
      self.nixosModules.gnome
      self.nixosModules.keyd
      self.nixosModules.virt-ydot
    ];
    networking.hostName = "niver";
    users.users.niver = {
      isNormalUser = true;
      description = "niver";
      extraGroups = ["networkmanager" "wheel" "input" "uinput" "ydotool" "libvirtd" "podman"];
    };
    services.getty.autologinUser = "niver";
  };
}
