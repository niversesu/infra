{pkgs, better-control, nur, system, ...}: {
  home.packages = with pkgs; [
    # System utilities
    cliphist
    github-copilot-cli
    gemini-cli-bin
    yt-dlp
    rclone

    # Development
    python3

    # File management
    kdePackages.filelight

    # Media & Design
    celluloid
    qpwgraph
    gimp3-with-plugins
    kdePackages.kdenlive

    # Multimedia
    motrix
    vesktop

    # Gaming
    prismlauncher
    packwiz
    minecraftia

    # Fonts
    nerd-fonts.jetbrains-mono

    # Browsers
    firefox
    google-chrome

    # Custom packages
    better-control.packages.${system}.default
    nur.repos.ataraxiasjel.waydroid-script
  ];
}
