{
  config,
  pkgs,
  ...
}: {
  # XDG / MIME Configuration
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/http" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/https" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/about" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/unknown" = ["com.google.Chrome.desktop"];
      "video/mp4" = ["celluloid.desktop"];
      "video/x-matroska" = ["celluloid.desktop"]; # .mkv
      "video/webm" = ["celluloid.desktop"];
    };
  };

  xdg.configFile."mimeapps.list".force = true;
}
