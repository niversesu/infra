{ self, ... }: {
  flake.homeModules.xdg = { config, pkgs, lib, ... }: {
    # XDG / MIME Configuration
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["com.google.Chrome.desktop"];
        "x-scheme-handler/http" = ["com.google.Chrome.desktop"];
        "x-scheme-handler/https" = ["com.google.Chrome.desktop"];
        "x-scheme-handler/about" = ["com.google.Chrome.desktop"];
        "x-scheme-handler/unknown" = ["com.google.Chrome.desktop"];
        "video/mp4" = ["io.github.celluloid_player.Celluloid.desktop"];
        "video/x-matroska" = ["io.github.celluloid_player.Celluloid.desktop"]; # .mkv
        "video/webm" = ["io.github.celluloid_player.Celluloid.desktop"];
        "audio/wav" = ["io.github.celluloid_player.Celluloid.desktop"];
      };
    };

    xdg.configFile."mimeapps.list".force = true;
  };
}
