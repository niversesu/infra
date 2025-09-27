{
  config,
  pkgs,
  spicetify-nix,
  caelestia-shell,
  caelestia-cli,
  better-control,
  nixvim,
  zen-browser,
  nixcord,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  spicePkgs = spicetify-nix.legacyPackages.${system};
in {
  # Import Hyprland configuration
  imports = [
    # ./hyprland.nix
    nixvim.homeModules.nixvim
    nixcord.homeModules.nixcord
  ];

  # User
  home.username = "niver";
  home.homeDirectory = "/home/niver";
  home.stateVersion = "25.05";

  # Nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Packages
  home.packages = with pkgs; [
    # Tools
    atool
    httpie
    eza
    fastfetch
    ripgrep
    cliphist
    fuzzel
    fzf
    kdePackages.filelight

    # Multimedia
    mpv
    celluloid
    gnome-sound-recorder
    qpwgraph
    lyrebird
    gnome-font-viewer

    # Theming
    whitesur-icon-theme
    adwaita-icon-theme
    adwaita-qt
    gimp3-with-plugins
    nwg-look
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum

    # Fun
    prismlauncher
    lutris

    # Misc
    wineWowPackages.full
    steam-run
    winetricks
    rclone
    slurp
    kitty

    # Custom flakes
    (caelestia-shell.packages.${system}.default.override {withCli = true;})
    caelestia-cli.packages.${system}.default
    better-control.packages.${system}.default
    zen-browser.packages.${system}.specific

    # Fonts (check if minecraftia exists in nixpkgs/overlay)
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
      package = pkgs.whitesur-icon-theme;
      # make sure this name actually exists in the package
      name = "WhiteSur-dark";
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };
  };

  # Qt theming
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Programs
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        nano = "nvim";
        ls = "eza";
      };
    };

    nixvim = {
      enable = true;

      colorschemes.catppuccin = {
        enable = true;
        settings.style = "default";
      };

      plugins = {
        lualine.enable = true;
        cmp.enable = true;
        vim-surround.enable = true;
        treesitter.enable = true;
        trouble.enable = true;
        which-key.enable = true;
        dashboard.enable = true;
        noice.enable = true;
        notify.enable = true;
        web-devicons.enable = true;
        neo-tree.enable = true;
        telescope.enable = true;
      };

      keymaps = [
        {
          key = "<C-n>";
          action = "<cmd>Neotree toggle<CR>";
          mode = "n"; # normal mode
          options.silent = true;
        }
      ];
    };

    nixcord = {
      enable = true;
      vesktop.enable = true;
      config = {
        plugins = {
          youtubeAdblock.enable = true;
          whoReacted.enable = true;
          betterFolders.enable = true;
        };
      };
    };

    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
      ];
    };

    git = {
      enable = true;
      userName = "niversesu";
      userEmail = "niversesu@gmail.com";
    };

    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        simpleBeautifulLyrics
        bestMoment
      ];
      theme = spicePkgs.themes.comfy;
    };

    ssh = {
      enable = true;
      extraConfig = ''
        Host github.com
          HostName ssh.github.com
          Port 443
          User git
          IdentityFile ~/.ssh/id_ed25519
          IdentitiesOnly yes
      '';
    };
  };

  # Services
  services.kdeconnect.enable = true;

  # Session variables
  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = "kvantum";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}
