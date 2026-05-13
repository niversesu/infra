{...}: {
  flake.nixosModules.core-nix = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.core.nix.enable = lib.mkEnableOption "Core Nix Settings";
    config = lib.mkIf config.mySystem.core.nix.enable {
      nix.settings = {
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["root" "faith" "niver" "amani"];
        substituters = [
          "https://cache.nixos.org"
          "https://nix-community.cachix.org"
          "https://niversesu.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "niversesu.cachix.org-1:d/IqQ2LR79Cq4/iK3qmCgKe1mxUi8uPSKhkEjhI/SOc="
        ];
        auto-optimise-store = true;
      };
      nixpkgs.config.allowUnfree = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;
      system.stateVersion = config.mySystem.shared.stateVersion;
    };
  };
}
