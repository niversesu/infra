{self, ...}: {
  flake.nixosConfigurations = {
    kale = self.lib.mkHost {
      module = self.nixosModules.host-kale;
      user = "niver";
      homeModule = self.homeModules.user-niver;
    };
    nomi = self.lib.mkHost {
      module = self.nixosModules.host-nomi;
      user = "faith";
      homeModule = self.homeModules.user-faith;
    };
    dream = self.lib.mkHost {
      module = self.nixosModules.host-dream;
      user = "amani";
      homeModule = self.homeModules.user-amani;
    };
  };
}
