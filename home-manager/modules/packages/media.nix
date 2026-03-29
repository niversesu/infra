{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    ffmpeg
    yt-dlp
  ];
}
