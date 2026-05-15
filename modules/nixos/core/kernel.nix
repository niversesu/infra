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
      (lib.mkIf (config.mySystem.core.kernel.type == "default") {
        boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
      })
      (lib.mkIf (config.mySystem.core.kernel.type == "zen") {
        boot.kernelPackages = pkgs.linuxPackages_zen;
      })
      (lib.mkIf (config.mySystem.core.kernel.type == "cachyos") {
        nixpkgs.overlays = [inputs.nix-cachyos-kernel.overlays.default];

        # Use the package from the overlay
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
        
        # Add cachyos binary cache (as per README)
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
      })
    ]);
  };
}
