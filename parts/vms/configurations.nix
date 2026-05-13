{self, ...}: {
  flake.nixosConfigurations = {
    # Kale VM - standard fixes + power boost
    kale-vm = self.lib.mkHost {
      module = self.nixosModules.host-kale;
      user = "niver";
      homeModule = self.homeModules.user-niver;
      extraModules = [
        self.nixosModules.vm-baseline
        self.nixosModules.vm-boost
      ];
    };

    # Nomi VM - just the standard fixes
    nomi-vm = self.lib.mkHost {
      module = self.nixosModules.host-nomi;
      user = "faith";
      homeModule = self.homeModules.user-faith;
      extraModules = [
        self.nixosModules.vm-baseline
      ];
    };

    # Dream VM - just the standard fixes
    dream-vm = self.lib.mkHost {
      module = self.nixosModules.host-dream;
      user = "amani";
      homeModule = self.homeModules.user-amani;
      extraModules = [
        self.nixosModules.vm-baseline
      ];
    };
  };
}
