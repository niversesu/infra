{
  inputs,
  ...
}: {
  flake.nixosModules.core-kernel = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.core.kernel = {
      enable = lib.mkEnableOption "Core Kernel Configuration" // { default = true; };
      type = lib.mkOption {
        type = lib.types.enum ["default" "cachyos" "zen"];
        default = "default";
        description = "Which kernel to use";
      };
    };

    config = lib.mkIf config.mySystem.core.kernel.enable (lib.mkMerge [
      {
        nix.settings = {
          substituters = [
            "https://attic.xuyh0120.win/lantian"
            "https://cache.garnix.io"
          ];
          trusted-public-keys = [
            "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
            "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          ];
        };
      }

      (lib.mkIf (config.mySystem.core.kernel.type == "default") {
        boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      })
      (lib.mkIf (config.mySystem.core.kernel.type == "zen") {
        boot.kernelPackages = pkgs.linuxPackages_zen;
      })
      (lib.mkIf (config.mySystem.core.kernel.type == "cachyos") {
        # DIRECT INJECTION: This avoids overlays and uses the exact binary from the flake
        # This is the most reliable way to force the binary cache to be used.
        boot.kernelPackages = inputs.nix-cachyos-kernel.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linuxPackages-cachyos-latest;
        
        # We still add the overlay just in case other parts of the system expect cachyosKernels
        nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.default];
      })
    ]);
  };
}
