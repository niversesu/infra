{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    illogical-flake = {
      url = "github:soymou/illogical-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
    quickshell = {
      url = "github:quickshell-mirror/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.54.2";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    illogical-dotfiles = {
      url = "git+https://github.com/end-4/dots-hyprland?submodules=1";
      flake = false;
    };
    caelestia-dotfiles = {
      url = "git+https://github.com/niversesu/caelestia?submodules=1";
      flake = false;
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
    };
    nix-packages = {
      url = "github:niversesu/nix-packages";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };
    wallpapers = {
      url = "github:niversesu/wallpapers";
      flake = false;
    };
  };
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];
      imports = [
        inputs.home-manager.flakeModules.home-manager
        (inputs.import-tree ./parts)
        (inputs.import-tree ./nixos/modules)
        ./nixos/configuration.nix
        ./nixos/packages.nix
        ./nixos/services.nix
        (inputs.import-tree ./hosts)
        (inputs.import-tree ./home-manager/modules)
        (inputs.import-tree ./home-manager/users)
        (inputs.import-tree ./variety)
      ];
      perSystem = {pkgs, ...}: {
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.nil ];
        };
      };
    };
}
