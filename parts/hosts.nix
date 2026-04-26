{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = {
    kale = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs self;
      };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        self.nixosModules.host-kale
        ({...}: {
          nixpkgs.overlays = [inputs.nur.overlays.default];
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs self;};
            users.niver = self.homeModules.user-niver;
          };
        })
      ];
    };
    nomi = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs self;
      };
      modules = [
        inputs.home-manager.nixosModules.home-manager
        self.nixosModules.host-nomi
        ({...}: {
          nixpkgs.overlays = [inputs.nur.overlays.default];
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs self;};
            users.faith = self.homeModules.user-faith;
          };
        })
      ];
    };
  };
}
