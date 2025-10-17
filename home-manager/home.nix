{
  config,
  pkgs,
  spicetify-nix,
  caelestia-shell,
  better-control,
  nixvim,
  nixcord,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  spicePkgs = spicetify-nix.legacyPackages.${system};
in {
  imports = [
    nixvim.homeModules.nixvim
    nixcord.homeModules.nixcord
  ];
  # User
  home.username = "niver";
  home.homeDirectory = "/home/niver";
  home.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;

  # File configurations
  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
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
    cliphist
    gh
    github-copilot-cli
    # Multimedia
    celluloid
    qpwgraph

    # Theming
    gimp3-with-plugins
    nerd-fonts.jetbrains-mono

    # Fun
    prismlauncher
    # Misc
    steam-run
    rclone
    kitty

    # Custom flakes
    (caelestia-shell.packages.${system}.default.override {withCli = true;})
    better-control.packages.${system}.default
    nur.repos.ataraxiasjel.waydroid-script
    # other things
    google-chrome
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
      package = pkgs.dracula-icon-theme;
      # make sure this name actually exists in the package
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
          betterSettings.enable = true;
          callTimer.enable = true;
          clearURLs.enable = true;
          copyStickerLinks.enable = true;
          customRPC.enable = true;
          fakeNitro.enable = true;
          favoriteEmojiFirst.enable = true;
          favoriteGifSearch.enable = true;
          iLoveSpam.enable = true;
          messageLogger.enable = true;
          imageZoom.enable = true;
        };
        useQuickCss = true; # use out quickCSS
        themeLinks = [
          # or use an online theme
          "https://capnkitten.github.io/BetterDiscord/Themes/Translucence/css/source.css"
        ];
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
      extraConfig = {
        init.defaultBranch = "main";
      };
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

    #ssh = {
    #enable = true;
    #enableDefaultConfig = false; # silence the warning
    #matchBlocks = {
    #"github.com" = {
    #host = "ssh.github.com";
    #port = 443;
    #user = "git";
    #identityFile = ["~/.ssh/id_ed25519"];
    #identitiesOnly = true;
    #};
    #};
    #};
  };

  # XDG settings
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/about" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/unknown" = "app.zen_browser.zen.desktop";
    };
  };

  # Services
  services.kdeconnect.enable = true;
}
