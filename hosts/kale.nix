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
    mySystem.host-kale-hw.enable = true;

    mySystem.gnome.enable = false;
    mySystem.caelestia.enable = true;

    mySystem.keyd.enable = true;
    mySystem.podman.enable = true;
    mySystem.libvirt.enable = true;
    mySystem.ydotool.enable = true;
    programs.steam.enable = true;
  };
}
