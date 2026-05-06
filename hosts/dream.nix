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

    mySystem.plasma.enable = true;
  };
}
