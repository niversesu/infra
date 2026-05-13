{self, ...}: {
  flake.nixosModules.host-kale = {...}: {
    imports = [
      self.nixosModules.shared
    ];

    mySystem.shared = {
      enable = true;
      user = "niver";
      host = "kale";
    };
    mySystem.profiles.desktop.enable = true;
    mySystem.profiles.virtualization.enable = true;
    mySystem.host-kale-hw.enable = true;

    mySystem.gnome.enable = false;
    mySystem.caelestia.enable = true;

    programs.steam.enable = true;
  };
}
