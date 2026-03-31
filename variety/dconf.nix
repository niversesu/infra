{ lib, ... }:
let inherit (lib.hm.gvariant) mkTuple mkUint32; in
{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      accent-color = "slate";
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Amber";
      font-name = "Noto Sans,  10";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Dracula";
    };

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/curvy-l.jxl";
      picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/curvy-d.jxl";
      primary-color = "#86b6ef";
      secondary-color = "#000000";
    };

    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/curvy-l.jxl";
      primary-color = "#86b6ef";
      secondary-color = "#000000";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 6.0;
      night-light-temperature = mkUint32 1700;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Super>p" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "kgx";
      name = "terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>e";
      command = "nautilus";
      name = "nautilus";
    };

    "org/gnome/shell" = {
      favorite-apps = [
        "google-chrome.desktop"
        "org.vinegarhq.Sober.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
  };
}
