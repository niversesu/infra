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

    mySystem.host-dream-hw.enable = true;
    mySystem.gnome.enble = false;
    mySystem.plasma.enable = true;
    programs.steam.enable = true;
  };
}
