{self, ...}: {
  flake.nixosModules.host-nomi = {...}: {
    imports = [
      self.nixosModules.shared
    ];

    mySystem.shared = {
      enable = true;
      user = "faith";
      host = "nomi";
    };
    mySystem.profiles.desktop.enable = true;
    mySystem.hardware.gpu = "intel";
    mySystem.host-nomi-hw.enable = true;
  };
}
