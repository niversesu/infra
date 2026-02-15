{
  description = "Home Manager + NixOS configuration of niver";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    better-control.url = "github:rishabh5321/better-control-flake";
    caelestia-shell.url = "github:caelestia-dots/shell";
    caelestia-cli.url = "github:caelestia-dots/cli";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    spicetify-nix,
    better-control,
    nixvim,
    nur,
    caelestia-shell,
    caelestia-cli,
    ...
  }: let
    system = "x86_64-linux";

    overlays = [nur.overlays.default];

    pkgs = import nixpkgs {
      inherit system overlays;
    };

    kubectl-aliases = pkgs.fetchFromGitHub {
      owner = "ahmetb";
      repo = "kubectl-aliases";
      rev = "master";
      sha256 = "sha256-NkprSk55aRVHiq9JXduQl6AGZv5pBLHznRToOdm9OUw=";
    };

    commonSpecialArgs = {
      inherit spicetify-nix better-control nixvim caelestia-shell caelestia-cli kubectl-aliases system;
      inherit nur;
      inputs = self.inputs;
    };
  in {
    nixosConfigurations.niver = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [./nixos/configuration.nix];
    };

    homeConfigurations."niver" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = commonSpecialArgs;
      modules = [
        spicetify-nix.homeManagerModules.default
        ./home-manager/home.nix
      ];
    };
  };
}
