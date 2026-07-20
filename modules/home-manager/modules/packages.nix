{...}: {
  flake.homeModules.packages = {
    inputs,
    pkgs,
    lib,
    config,
    osConfig,
    ...
  }: let
    cfg = config.myHome.packages;
  in {
    options.myHome.packages = {
      enable = lib.mkEnableOption "packages";
      remotetools.enable = lib.mkEnableOption "Remote & filesystem tools" // {default = true;};
      fonts.enable = lib.mkEnableOption "Personal font collection" // {default = true;};
      gaming.enable = lib.mkEnableOption "Gaming tools";
      browsers.enable = lib.mkEnableOption "Web browsers" // {default = true;};
      communication.enable = lib.mkEnableOption "Communication tools";
      media.enable = lib.mkEnableOption "Media tools" // {default = true;};
      filemanagement.enable = lib.mkEnableOption "File management" // {default = true;};
      cliutilities.enable = lib.mkEnableOption "CLI utilities" // {default = true;};
      creative.enable = lib.mkEnableOption "Creative tools";
      tech-tools.enable = lib.mkEnableOption "Tech tools";
    };

    config = lib.mkIf cfg.enable (lib.mkMerge [
      (lib.mkIf cfg.remotetools.enable {
        home.packages = [pkgs.remmina];
      })
      (lib.mkIf cfg.fonts.enable {
        home.packages = with pkgs; [
          nerd-fonts.jetbrains-mono
          meslo-lgs-nf
          minecraftia
          montserrat
          comfortaa
        ];
      })
      (lib.mkIf cfg.gaming.enable {
        home.packages = [pkgs.prismlauncher pkgs.packwiz];
      })
      (lib.mkIf cfg.browsers.enable {
        home.packages = [pkgs.firefox];
      })
      (lib.mkIf cfg.communication.enable {
        home.packages = [pkgs.vesktop];
      })
      (lib.mkIf (osConfig.mySystem.waydroid.enable or false) {
        home.packages = with pkgs; [
          nur.repos.ataraxiasjel.waydroid-script
          waydroid-helper
        ];
      })
      (lib.mkIf cfg.media.enable {
        home.packages = with pkgs; [celluloid ffmpeg yt-dlp];
      })
      (lib.mkIf cfg.filemanagement.enable {
        home.packages = with pkgs; [kdePackages.filelight rclone localsend];
      })
      (lib.mkIf cfg.cliutilities.enable {
        home.packages = with pkgs; [devenv];
      })
      (lib.mkIf cfg.creative.enable {
        home.packages = with pkgs; [krita inputs.nix-packages.packages.${pkgs.stdenv.hostPlatform.system}.nix-photogimp kdePackages.kdenlive];
      })
      (lib.mkIf cfg.tech-tools.enable {
        home.packages = with pkgs; [keyd ydotool distrobox nixos-container];
      })
    ]);
  };
}
