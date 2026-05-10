{inputs, ...}:
let
  system = "x86_64-linux";

  # Workaround for quickshell build race condition in QML type registration.
  # Automatic QML type registration generates _qmltyperegistrations.cpp files
  # but ninja tries to compile them before generation completes (missing dependency).
  # Fix: disable PCH, force single-threaded ninja (-j1), and use clang (recommended
  # by upstream for faster builds; also handles generated file dependencies better).
  qsPackage = inputs.quickshell.packages.${system}.default;
  nixpkgs = inputs.nixpkgs.legacyPackages.${system};
  fixedQuickshell = qsPackage.unwrapped.overrideAttrs (old: {
    cmakeFlags = (old.cmakeFlags or []) ++ [
      "-DNO_PCH=ON"
    ];

    preBuild = ''
      export NIX_BUILD_CORES=1
      # Qt6 generates _qmltyperegistrations.cpp at build time but the ninja
      # dependencies are missing. We generate empty stubs here so compilation
      # doesn't fail; Qt's qmltyperegistrar will overwrite them later.
      if [ -f build/build.ninja ]; then
        sed -n 's/.*:.* \([^ ]*_qmltyperegistrations\.cpp\)$/\1/p' build/build.ninja \
          | sort -u | while read src; do
            mkdir -p "$(dirname "build/$src")"
            touch "build/$src"
          done
      fi
    '';
  });
in {
  flake.nixosModules.illogical = {
    config,
    pkgs,
    lib,
    ...
  }: {
    options.mySystem.illogical.enable = lib.mkEnableOption "illogical impulse";

    config = lib.mkIf config.mySystem.illogical.enable {
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      };
      services.geoclue2.enable = true;
      networking.networkmanager.enable = true;
      services.upower.enable = true;
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      environment.systemPackages = with pkgs; [
        qt5.qtgraphicaleffects
        qt6.qt5compat
        qt6.qtpositioning
        kdePackages.syntax-highlighting
      ];
    };
  };

  flake.homeModules.illogical = {
    pkgs,
    lib,
    osConfig,
    ...
  }: let
    cfg = osConfig.mySystem.illogical;
    flakeSrc = "${inputs.illogical-flake}";
    customPkgs = import "${flakeSrc}/pkgs" { inherit pkgs; };

    qtImports = with pkgs; [
      kdePackages.qtbase kdePackages.qtdeclarative kdePackages.qtsvg
      kdePackages.qtwayland kdePackages.qt5compat kdePackages.qtimageformats
      kdePackages.qtmultimedia kdePackages.qtpositioning kdePackages.qtsensors
      kdePackages.qtquicktimeline kdePackages.qttools kdePackages.qttranslations
      kdePackages.qtvirtualkeyboard kdePackages.qtwebsockets
      kdePackages.syntax-highlighting kdePackages.kirigami.unwrapped
    ];

    pythonEnv = pkgs.python3.withPackages (ps: [
      ps.build ps.cffi ps.click ps."dbus-python" ps."kde-material-you-colors"
      ps.libsass ps.loguru ps."material-color-utilities" ps.materialyoucolor
      ps.numpy ps.pillow ps.psutil ps.pycairo ps.pygobject3 ps.pywayland
      ps.setproctitle ps."setuptools-scm" ps.tqdm ps.wheel ps."pyproject-hooks"
      ps.opencv4
    ]);
  in {
    # Import illogical-flake submodules except qt.nix (which uses unfixed quickshell)
    imports = let
      flakeSrc = "${inputs.illogical-flake}";
      subInputs = {
        inherit (inputs) nur;
        dotfiles = inputs.illogical-dotfiles;
        quickshell = inputs.quickshell;
      };
    in [
      (import "${flakeSrc}/home-modules/fonts.nix" subInputs)
      (import "${flakeSrc}/home-modules/packages.nix" subInputs)
      (import "${flakeSrc}/home-modules/environment.nix" subInputs)
      (import "${flakeSrc}/home-modules/dotfiles.nix" subInputs)
    ];

    # Define option that is normally defined in home-module.nix
    options.programs.illogical-impulse.enable = lib.mkEnableOption "Enable the Illogical Impulse Hyprland configuration";

    config = lib.mkIf (cfg.enable or false) {
      programs.illogical-impulse = {
        enable = true;
        dotfiles = {
          fish.enable = true;
          kitty.enable = true;
          starship.enable = true;
        };
        hyprland.plugins = [
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
          inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
        ];
      };

      # qs wrapper with fixed quickshell (replaces the one from qt.nix which we don't import)
      home.packages = [
        (pkgs.writeShellScriptBin "qs" ''
          export QT_PLUGIN_PATH="${lib.makeSearchPath "lib/qt-6/plugins" qtImports}:${lib.makeSearchPath "lib/qt6/plugins" qtImports}:${lib.makeSearchPath "lib/plugins" qtImports}"
          export QML2_IMPORT_PATH="${lib.makeSearchPath "lib/qt-6/qml" qtImports}"
          export XDG_DATA_DIRS="${lib.makeSearchPath "share" [
            pkgs.adwaita-icon-theme pkgs.hicolor-icon-theme pkgs.papirus-icon-theme
            customPkgs.illogical-impulse-oneui4-icons pkgs.gnome-icon-theme
            pkgs.kdePackages.breeze-icons pkgs.lxqt.pavucontrol-qt pkgs.pavucontrol
          ]}:$HOME/.nix-profile/share:$HOME/.local/share:/etc/profiles/per-user/$USER/share:/run/current-system/sw/share:/usr/share:$XDG_DATA_DIRS"
          export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          export QT_QPA_PLATFORMTHEME=gtk3
          exec ${fixedQuickshell}/bin/qs "$@"
        '')
      ] ++ qtImports ++ [
        pkgs.qt6Packages.qt6ct
        pythonEnv
      ];
    };
  };
}
