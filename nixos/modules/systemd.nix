{ config, pkgs, lib, ... }:

{
  systemd.services.ntfsfix-sda4 = {
    description = "Run ntfsfix on /dev/sda4 at boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "local-fs.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ntfs3g}/bin/ntfsfix -d /dev/sda4";
    };
  };
}
