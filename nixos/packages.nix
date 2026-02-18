{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xhost                       # X11 access control utility (allow/deny display access)
    ntfs3g                      # NTFS filesystem driver for mounting Windows drives
    fastfetch                   # Fast system info display tool (like neofetch)
    ripgrep                     # Very fast recursive text search tool (rg)
    ffmpeg                      # Audio/video conversion and processing toolkit
    pavucontrol                 # PulseAudio/PipeWire volume control GUI
    fcp                         # Fast recursive copy tool with progress display
    sassc                       # Command-line SASS/SCSS compiler
    gparted                     # disk management
    libgda6                     # for copyous gnome extension
    gsound                      # for copyous gnome extension too 
    alejandra                   # Nix code formatter
    unzip                       # Extract .zip archives
    qpwgraph                    # PipeWire graph patchbay and connection manager
    keyd                        # Low-level keyboard remapping daemon
    httpie                      # Human-friendly HTTP client (curl alternative)
    nmap                        # Network scanner and port discovery tool
    aria2                       # Multi-source download manager (HTTP/FTP/torrent)
    eza                         # Modern replacement for ls with icons and git info
    wget                        # Command-line file downloader
    curl                        # Command-line data transfer tool
    home-manager                # Declarative per-user Nix configuration manager
    wl-clipboard                # Clipboard utilities for Wayland (wl-copy/wl-paste)
    ydotool                     # Wayland-compatible input automation tool
    gnomeExtensions.appindicator # GNOME extension for legacy tray icons
    gnomeExtensions.copyous      # GNOME clipboard manager extension
    gnomeExtensions.blur-my-shell # GNOME blur/transparency effects extension
    distrobox                   # Run other Linux distros inside containers
    waydroid-helper             # Helper tools for managing Waydroid Android container
    podman-compose              # Docker-compose-like tool for Podman
  ];
}

