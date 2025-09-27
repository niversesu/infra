{config, pkgs, ...}: {
  services = {
    keyd = {
      enable = true;
      keyboards.default = {
        ids = ["*"];
        settings = {
          main = {
            leftalt = "leftmeta";
            muhenkan = "leftalt";
          };
        };
      };
    };

    xserver.xkb = {
      layout = "us";
      variant = "";
    };

    getty.autologinUser = "niver";
    flatpak.enable = true;
    upower.enable = true;
  };

  programs = {
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };
  };
}
