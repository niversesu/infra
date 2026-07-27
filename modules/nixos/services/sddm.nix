{inputs, ...}: {
  flake.nixosModules.sddm = {
    config,
    lib,
    pkgs,
    ...
  }: let
    themes = {
      astronaut = {
        name = "sddm-astronaut-theme";
        package = pkgs.sddm-astronaut.override {
          embeddedTheme = "hyprland_kath";
          themeConfig = {
            Background = "${inputs.media}/${config.mySystem.services.sddm.video}/${config.mySystem.services.sddm.video}.mp4";
            BackgroundPlaceholder = "${inputs.media}/${config.mySystem.services.sddm.video}/${config.mySystem.services.sddm.video}.png";
            HeaderTextColor = "#f5f5f5";
            DateTextColor = "#f5f5f5";
            TimeTextColor = "#f5f5f5";
            FormBackgroundColor = "#0a0a0a";
            BackgroundColor = "#0a0a0a";
            DimBackgroundColor = "#0a0a0a";
            LoginFieldBackgroundColor = "#1a1a1a";
            PasswordFieldBackgroundColor = "#1a1a1a";
            LoginFieldTextColor = "#f5f5f5";
            PasswordFieldTextColor = "#f5f5f5";
            UserIconColor = "#c0151a";
            PasswordIconColor = "#c0151a";
            PlaceholderTextColor = "#888888";
            WarningColor = "#c0151a";
            LoginButtonTextColor = "#f5f5f5";
            LoginButtonBackgroundColor = "#c0151a";
            SystemButtonsIconsColor = "#f5f5f5";
            SessionButtonTextColor = "#f5f5f5";
            VirtualKeyboardButtonTextColor = "#f5f5f5";
            DropdownTextColor = "#f5f5f5";
            DropdownSelectedBackgroundColor = "#c0151a";
            DropdownBackgroundColor = "#2a0a0a";
            HighlightTextColor = "#f5f5f5";
            HighlightBackgroundColor = "#c0151a";
            HighlightBorderColor = "transparent";
            HoverUserIconColor = "#c0151a";
            HoverPasswordIconColor = "#c0151a";
            HoverSystemButtonsIconsColor = "#c0151a";
            HoverSessionButtonTextColor = "#c0151a";
            HoverVirtualKeyboardButtonTextColor = "#c0151a";
          };
        };
        extraPackages = with pkgs; [
          kdePackages.qtmultimedia
          gst_all_1.gstreamer
          gst_all_1.gst-plugins-base
          gst_all_1.gst-libav
        ];
      };

      noctalia = {
        name = "noctalia";
        package = inputs.nix-packages.packages.${pkgs.stdenv.hostPlatform.system}.sddm-noctalia.override {
          themeConfig = config.mySystem.services.sddm.noctalia.themeConfig;
        };
        extraPackages = [];
      };

      pixel = {
        name = "pixel";
        package = inputs.nix-packages.packages.${pkgs.stdenv.hostPlatform.system}.sddm-pixel;
        extraPackages = [];
      };
    };

    selectedTheme = themes.${config.mySystem.services.sddm.theme} or null;
  in {
    options.mySystem.services.sddm = {
      enable = lib.mkEnableOption "sddm";
      theme = lib.mkOption {
        type = lib.types.enum (builtins.attrNames themes ++ ["none"]);
        default = "none";
        description = "The SDDM theme to use";
      };
      video = lib.mkOption {
        type = lib.types.enum ["sukuna"];
        default = "sukuna";
        description = "The video that will be played";
      };
      noctalia = {
        themeConfig = lib.mkOption {
          type = lib.types.attrs;
          default = {};
          description = "Noctalia theme configuration overrides";
        };
      };
    };
    config = lib.mkIf config.mySystem.services.sddm.enable {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme =
          if selectedTheme != null
          then selectedTheme.name
          else null;
        extraPackages =
          if selectedTheme != null
          then selectedTheme.extraPackages
          else [];
      };
      environment.systemPackages =
        if selectedTheme != null
        then [selectedTheme.package]
        else [];
    };
  };
}
