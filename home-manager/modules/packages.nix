{inputs, ...}: {
  flake.homeModules.packages = {
    pkgs,
    lib,
    config,
    osConfig,
    ...
  }: let
    cfg = config.my.packages;
  in {
    options.my.packages = {
      remotetools.enable = lib.mkEnableOption "Remote & filesystem tools (remmina, ntfs3g)" // {default = true;};
      fonts.enable = lib.mkEnableOption "Personal font collection (JetBrains Mono, Meslo, Minecraftia, Montserrat)" // {default = true;};
      gaming.enable = lib.mkEnableOption "Gaming tools (Prism Launcher, Packwiz)";
      browsers.enable = lib.mkEnableOption "Web browsers (Firefox, Google Chrome)" // {default = true;};
      communication.enable = lib.mkEnableOption "Communication tools (Vesktop)";
      media.enable = lib.mkEnableOption "Media tools (Celluloid, FFmpeg, yt-dlp)" // {default = true;};
      filemanagement.enable = lib.mkEnableOption "File management (Filelight, Rclone)" // {default = true;};
      cliutilities.enable = lib.mkEnableOption "CLI utilities (gemini-cli, claude-code)" // {default = true;};
      creative.enable = lib.mkEnableOption "Creative tools (Krita, GIMP3, Kdenlive)";
      tech-tools.enable = lib.mkEnableOption "Tech tools (keyd, ydotool, distrobox, podman-compose)";
    };

    config = {
      home.packages = with pkgs;
        (lib.optionals cfg.remotetools.enable [
          remmina
          ntfs3g
        ])
        ++ (lib.optionals cfg.fonts.enable [
          nerd-fonts.jetbrains-mono
          meslo-lgs-nf
          minecraftia
          montserrat
        ])
        ++ (lib.optionals cfg.gaming.enable [
          prismlauncher
          packwiz
        ])
        ++ (lib.optionals cfg.browsers.enable [
          firefox
          google-chrome
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ])
        ++ (lib.optionals cfg.communication.enable [
          vesktop
        ])
        ++ (lib.optionals (osConfig.mySystem.virt.waydroid.enable or false) [
          pkgs.nur.repos.ataraxiasjel.waydroid-script
          waydroid-helper
        ])
        ++ (lib.optionals cfg.media.enable [
          celluloid
          ffmpeg
          yt-dlp
        ])
        ++ (lib.optionals cfg.filemanagement.enable [
          kdePackages.filelight
          rclone
        ])
        ++ (lib.optionals cfg.cliutilities.enable [
          gemini-cli-bin
          claude-code
          opencode
        ])
        ++ (lib.optionals cfg.creative.enable [
          krita
          gimp3-with-plugins
          kdePackages.kdenlive
        ])
        ++ (lib.optionals cfg."tech-tools".enable [
          keyd
          ydotool
          distrobox
          podman-compose
          nixos-container
        ]);
    };
  };
}
