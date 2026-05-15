{...}: {
  flake.nixosModules.jellyfin = {
    config,
    lib,
    ...
  }: {
    options.mySystem.jellyfin = {
      enable = lib.mkEnableOption "jellyfin";
      domain = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "Domain for Jellyfin reverse proxy (e.g. jellyfin.local)";
      };
    };

    config = lib.mkIf config.mySystem.jellyfin.enable {
      users.groups.multimedia = {};
      users.users.${config.mySystem.shared.user}.extraGroups = ["multimedia"];

      services.jellyfin = {
        enable = true;
        group = "multimedia";
      };

      services.caddy.virtualHosts = lib.mkIf (config.mySystem.jellyfin.domain != null) {
        "http://${config.mySystem.jellyfin.domain}".extraConfig = ''
          reverse_proxy localhost:8096
        '';
      };

      networking.hosts."127.0.0.1" = lib.optional (config.mySystem.jellyfin.domain != null) config.mySystem.jellyfin.domain;

      systemd.services.jellyfin.wantedBy = lib.mkForce [];

      systemd.tmpfiles.rules = [
        "z /home/${config.mySystem.shared.user} 0750 ${config.mySystem.shared.user} multimedia - -"
        "Z /home/${config.mySystem.shared.user}/shows 2770 ${config.mySystem.shared.user} multimedia - -"
      ];

      users.users.jellyfin.extraGroups =
        (lib.optional (config.mySystem.hardware.gpu != "none") "render")
        ++ (lib.optional (config.mySystem.hardware.gpu != "none") "video");
    };
  };
}
