{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    remmina
    ntfs3g                      # NTFS filesystem driver for mounting Windows drives
    fastfetch                   # Fast system info display tool (like neofetch)
    ripgrep                     # Very fast recursive text search tool (rg)
    ffmpeg                      # Audio/video conversion and processing toolkit
    fcp                         # Fast recursive copy tool with progress display
    gparted                     # disk management 
    alejandra                   # Nix code formatter
    unzip                       # Extract .zip archives
    keyd                        # Low-level keyboard remapping daemon
    aria2                       # Multi-source download manager (HTTP/FTP/torrent)
    eza                         # Modern replacement for ls with icons and git info
    wget                        # Command-line file downloader
    curl                        # Command-line data transfer tool
    home-manager                # Declarative per-user Nix configuration manager
    wl-clipboard                # Clipboard utilities for Wayland (wl-copy/wl-paste)
    ydotool                     # Wayland-compatible input automation tool
    distrobox                   # Run other Linux distros inside containers
    waydroid-helper             # Helper tools for managing Waydroid Android container
    podman-compose              # Docker-compose-like tool for Podman
  ];
}

