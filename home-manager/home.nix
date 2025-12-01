{
  config,
  pkgs,
  spicetify-nix,
  better-control,
  nixvim,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  spicePkgs = spicetify-nix.legacyPackages.${system};
in {
  imports = [
    nixvim.homeModules.nixvim
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
    motrix

    python3
    celluloid
    qpwgraph

    gimp3-with-plugins
    nerd-fonts.jetbrains-mono

    prismlauncher
    packwiz
    steam-run
    rclone

    kitty
    vesktop
    kdePackages.kdenlive

    better-control.packages.${system}.default
    nur.repos.ataraxiasjel.waydroid-script

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

  # Programs
  programs = {
    fish = {
      enable = true;
      shellAliases = {
        nano = "nvim";
        ls = "eza";
	snrs = "sudo nixos-rebuild switch";
	hs = "home-manager switch";
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

    vscode = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
      ];
    };

    git = {
      enable = true;
      settings = {
        user.name = "niversesu";
        user.email = "niversesu@gmail.com";
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
  };

  # XDG settings
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/http" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/https" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/about" = ["com.google.Chrome.desktop"];
      "x-scheme-handler/unknown" = ["com.google.Chrome.desktop"];
    };
  };

  # Services
  services.kdeconnect.enable = true;
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-gtk fcitx5-rime rime-data];
  };
}
