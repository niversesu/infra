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
    mySystem.hardware.gpu = "intel";
    mySystem.host-kale-hw.enable = true;
    mySystem.core.kernel.type = "cachyos";

    mySystem.gnome.enable = false;
    mySystem.caelestia.enable = true;
    mySystem.jellyfin = {
      enable = true;
      domain = "jellyfin.kale";
    };
    mySystem.waydroid.enable = true;

    programs.steam.enable = true;
  };
}
