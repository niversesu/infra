{pkgs, ...}: {
  home.packages = with pkgs; [
    cliphist
    github-copilot-cli
    gemini-cli-bin
    yt-dlp
  ];
}
