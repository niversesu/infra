{
  self,
  inputs,
  ...
}: {
  flake.lib = {
    mkHost = {
      module,
      user,
      homeModule,
      system ? "x86_64-linux",
      extraModules ? [],
    }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs self;};
        modules =
          [
            {nixpkgs.hostPlatform = system;}
            inputs.home-manager.nixosModules.home-manager
            inputs.agenix.nixosModules.default
            inputs.agenix-rekey.nixosModules.default
            module
            ({...}: {
              nixpkgs.overlays = [inputs.nur.overlays.default];
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {inherit inputs self;};
                sharedModules = [];
                users.${user} = homeModule;
              };
            })
          ]
          ++ extraModules;
      };
  };
}
