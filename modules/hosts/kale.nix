{self, ...}: {
  flake.nixosModules.host-kale = {config, ...}: {
    imports = [
      self.nixosModules.shared
    ];

    mySystem.shared = {
      enable = true;
      user = "niver";
      host = "kale";
    };
    mySystem.profiles.desktop.enable = true;
    mySystem.profiles.virtualization.enable = true;
    mySystem.hardware.gpu = "intel";
    mySystem.host-kale-hw.enable = true;
    mySystem.core.kernel.type = "cachyos";

    mySystem.core.nixbuild = {
      enable = true;
      identityFile = config.sops.secrets.nixbuildKey.path;
    };

    mySystem.gnome.enable = false;
    mySystem.noctalia.enable = true;
    mySystem.jellyfin = {
      enable = true;
      domain = "jellyfin.kale";
    };
    mySystem.waydroid.enable = true;

    programs.steam.enable = true;
  };
}
