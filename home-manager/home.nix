{ 
  config,
  pkgs,
  better-control,
  nixvim,
  caelestia-shell,
  caelestia-cli,  ...
}: {
  imports = [
    nixvim.homeModules.nixvim
    ./modules/fish.nix
    ./modules/starship.nix
    ./modules/nixvim.nix
    ./modules/vscode.nix
    ./modules/git.nix
    ./modules/spicetify.nix
  ];
  # User
  home.username = "niver";
  home.homeDirectory = "/home/niver";
  home.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  # Packages
  home.packages = with pkgs; [
    cliphist
    kdePackages.filelight
    github-copilot-cli
    gemini-cli-bin
    motrix
    yt-dlp
    python3
    celluloid
    qpwgraph

    gimp3-with-plugins
    nerd-fonts.jetbrains-mono

    prismlauncher
    packwiz
    rclone

    vesktop
    kdePackages.kdenlive

    better-control.packages.${system}.default
    nur.repos.ataraxiasjel.waydroid-script
    firefox
    google-chrome
    minecraftia
  ];

  # GTK theming
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    iconTheme = {
      package = pkgs.dracula-icon-theme;
      name = "Dracula";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
  };
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;

    x11.enable = true;
  };



  # XDG settings
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["com.google.Chrome.desktop"];
        "x-scheme-handler/http" = ["com.google.Chrome.desktop"];
        "x-scheme-handler/https" = ["com.google.Chrome.desktop"];
        "x-scheme-handler/about" = ["com.google.Chrome.desktop"];
        "x-scheme-handler/unknown" = ["com.google.Chrome.desktop"];
      };
    };
    configFile."mimeapps.list".force = true;

  # Services
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
  };
}
