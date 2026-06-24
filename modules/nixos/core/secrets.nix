{self, ...}: {
  perSystem = {config, ...}: {};

  flake.nixosModules.core-secrets = {
    config,
    lib,
    ...
  }: {
    options.mySystem.core.secrets.enable = lib.mkEnableOption "Secrets Management";
    config = lib.mkIf config.mySystem.core.secrets.enable {
      sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      sops.defaultSopsFile = ../../../secrets/secrets.yaml;

      sops.secrets.userPassword = {
        neededForUsers = true;
        key = {
          kale = "niverPassword";
          nomi = "faithPassword";
          dream = "amaniPassword";
        }.${config.mySystem.shared.host};
      };

      sops.secrets.tailscaleAuthKey = {};

      sops.secrets.nixbuildKey = {
        owner = "root";
        mode = "0600";
      };

      users.users.${config.mySystem.shared.user}.hashedPasswordFile =
        config.sops.secrets.userPassword.path;
      users.users.recovery.hashedPasswordFile =
        config.sops.secrets.userPassword.path;
      services.tailscale.authKeyFile =
        config.sops.secrets.tailscaleAuthKey.path;
    };
  };
}
