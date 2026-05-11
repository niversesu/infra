{inputs, ...}: {
  flake.nixosModules.obs-studio = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.obs-studio.enable = lib.mkEnableOption "obs-studio";
    config = lib.mkIf config.mySystem.obs-studio.enable {
      programs.obs-studio = {
        enable = true;
        enableVirtualCamera = true;
        plugins = with pkgs.obs-studio-plugins; [
          obs-pipewire-audio-capture
          inputs.nix-packages.packages.${pkgs.system}.obs-pwvideo
        ];
      };
      boot.extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback
      ];
      boot.kernelModules = ["v4l2loopback"];
      boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
      security.polkit.enable = true;
    };
  };
}
