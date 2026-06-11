{inputs, ...}: {
  perSystem = {config, ...}: {
    agenix-rekey.nixosConfigurations = inputs.self.nixosConfigurations;
  };

  flake.nixosModules.core-secrets = {
    config,
    lib,
    ...
  }: {
    options.mySystem.core.secrets.enable = lib.mkEnableOption "Secrets Management";
    config = lib.mkIf config.mySystem.core.secrets.enable {
      age.rekey = {
        storageMode = "local";
        masterIdentities = ["/home/niver/.config/age/master.key"];
        hostPubkey =
          {
            kale = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG248Xo+x2LZ31Hcadp/bmOLynBUVrWH3IBs2ihG7zgE";
            nomi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEbTykCxRKF6rK9aVv2mddNFx2Ujnk78aavmQb9OWhkn";
            dream = "age1qyqszqgpqyqszqgpqyqszqgpqyqszqgpqyqszqgpqyqszqgpqyqs3290gq";
          }.${
            config.mySystem.shared.host
          };
        localStorageDir = ./../../../secrets/rekeyed + "/${config.networking.hostName}";
      };

      age.secrets.userPassword.rekeyFile =
        {
          kale = ../../../secrets/passwords/niver-pass.age;
          nomi = ../../../secrets/passwords/faith-pass.age;
          dream = ../../../secrets/passwords/amani-pass.age;
        }.${
          config.mySystem.shared.host
        };
      age.secrets.tailscaleAuthKey.rekeyFile = ../../../secrets/tailscale/authkey.age;
      age.secrets.nixbuildKey = {
        rekeyFile = ../../../secrets/key/nixbuild-key.age;
        owner = "root";
        group = "root";
        mode = "0600";
      };
      users.users.${config.mySystem.shared.user}.hashedPasswordFile =
        config.age.secrets.userPassword.path;
      users.users.recovery.hashedPasswordFile = config.age.secrets.userPassword.path;
      services.tailscale.authKeyFile = config.age.secrets.tailscaleAuthKey.path;
    };
  };
}
