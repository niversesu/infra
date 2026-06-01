{inputs, ...}: {
  flake.nixosModules.sddm = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.mySystem.services.sddm = {
      enable = lib.mkEnableOption "sddm";
      theme = lib.mkOption {
        type = lib.types.enum ["astronaut" "none"];
        default = "none";
        description = "The SDDM theme to use";
      };
      video = lib.mkOption {
        type = lib.types.enum ["sukuna"];
        default = "sukuna";
        description = "The video that will be played";
      };
    };
    config = lib.mkIf config.mySystem.services.sddm.enable {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = lib.mkIf (config.mySystem.services.sddm.theme == "astronaut") "sddm-astronaut-theme";
        extraPackages = lib.mkIf (config.mySystem.services.sddm.theme == "astronaut") (with pkgs; [
          kdePackages.qtmultimedia
          gst_all_1.gstreamer
          gst_all_1.gst-plugins-base
          gst_all_1.gst-libav
        ]);
      };

      environment.systemPackages = lib.mkIf (config.mySystem.services.sddm.theme == "astronaut") [
        (pkgs.sddm-astronaut.override {
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
        })
      ];
    };
  };
}
