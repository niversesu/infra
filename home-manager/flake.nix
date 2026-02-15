{
  description = "Home Manager + NixOS configuration of niver";

  inputs = {
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    better-control.url = "github:rishabh5321/better-control-flake";
    caelestia-shell.url = "github:caelestia-dots/shell";
    caelestia-cli.url = "github:caelestia-dots/cli";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
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

    overlays = [
      nur.overlays.default
    ];

    pkgs = import nixpkgs {
      inherit system overlays;
    };

    kubectl-aliases = pkgs.fetchFromGitHub {
      owner = "ahmetb";
      repo = "kubectl-aliases";
      rev = "master";
      sha256 = "sha256-NkprSk55aRVHiq9JXduQl6AGZv5pBLHznRToOdm9OUw=";
    };
  in {
    # ✅ NixOS system configuration (for nixos-rebuild)
    nixosConfigurations.niver = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./home.nix
      ];
    };

    # ✅ Home Manager standalone config (for home-manager switch)
    homeConfigurations."niver" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit spicetify-nix better-control nixvim caelestia-shell caelestia-cli kubectl-aliases;
        inputs = self.inputs;
      };
      modules = [
        spicetify-nix.homeManagerModules.default
        ./modules/spicetify.nix
        ./home.nix
      ];
    };
  };
}
