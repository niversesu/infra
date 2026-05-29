{self, ...}: {
  flake.nixosModules.host-dream = {...}: {
    imports = [
      self.nixosModules.shared
    ];

    mySystem.shared = {
      enable = true;
      user = "amani";
      host = "dream";
    };
    mySystem.profiles.desktop.enable = true;
    mySystem.hardware.gpu = "intel";
    mySystem.host-dream-hw.enable = true;
    mySystem.gnome.enable = false;
    mySystem.plasma.enable = false;
    mySystem.caelestia.enable = true;
    programs.steam.enable = true;
  };
}
