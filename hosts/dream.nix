{self, ...}: {
  flake.nixosModules.host-dream = {lib, ...}: {
    imports = [
      self.nixosModules.shared
    ];

    mySystem.shared = {
      enable = true;
      user = "amani";
      host = "dream";
    };

    boot.loader = {
      systemd-boot.enable = lib.mkForce false;
      grub.enable = lib.mkForce true;
    };
    mySystem.host-dream-hw.enable = true;
    mySystem.gnome.enable = false;
    mySystem.plasma.enable = false;
    mySystem.caelestia.enable = true;
    programs.steam.enable = true;
  };
}
