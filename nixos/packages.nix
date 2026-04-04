{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fastfetch                   # Fast system info display tool (like neofetch)
    ripgrep                     # Very fast recursive text search tool (rg)
    gparted                     # disk management 
    alejandra                   # Nix code formatter
    unzip                       # Extract .zip archives
    aria2                       # Multi-source download manager (HTTP/FTP/torrent)
    eza                         # Modern replacement for ls with icons and git info
    wget                        # Command-line file downloader
    curl                        # Command-line data transfer tool
    home-manager                # Declarative per-user Nix configuration manager
    wl-clipboard                # Clipboard utilities for Wayland (wl-copy/wl-paste)
    waydroid-helper             # Helper tools for managing Waydroid Android container
    cpx
  ];
}

