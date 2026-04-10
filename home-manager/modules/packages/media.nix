{ self, ... }: {
  flake.homeModules.pkg-media = { pkgs, ... }: {
  home.packages = with pkgs; [
    celluloid
    ffmpeg
    yt-dlp
  ];
};
}
