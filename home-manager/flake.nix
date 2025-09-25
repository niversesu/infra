{
  description = "Home Manager + NixOS configuration of niver";

  inputs = {
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    better-control.url = "github:rishabh5321/better-control-flake";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    spicetify-nix,
    caelestia-shell,
    caelestia-cli,
    better-control,
    nix-minecraft,
    nixvim,
    ...
  }: let
    system = "x86_64-linux";
  in {
    # ✅ NixOS system configuration (for nixos-rebuild)
    nixosConfigurations.niver = nixpkgs.lib.nixosSystem {
      inherit system;
      inherit nix-minecraft;
      modules = [
        ./configuration.nix
        ./minecraft.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.niver = import ./home.nix;
        }
      ];
    };

    # ✅ Home Manager standalone config (for home-manager switch)
    homeConfigurations."niver" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = {
        inherit spicetify-nix caelestia-shell caelestia-cli better-control nix-minecraft nixvim;
      };
      modules = [
        spicetify-nix.homeManagerModules.default
        ./home.nix
      ];
    };
  };
}

