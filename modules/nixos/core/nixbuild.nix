{self, ...}: {
  flake.nixosModules.core-nixbuild = {
    config,
    lib,
    ...
  }: {
    options.mySystem.core.nixbuild = {
      enable = lib.mkEnableOption "nixbuild.net distributed builds";
      identityFile = lib.mkOption {
        type = lib.types.path;
        default = "/root/.ssh/id_nixbuild";
        description = "Path to the SSH private key used to authenticate with nixbuild.net";
      };
    };

    config = lib.mkIf config.mySystem.core.nixbuild.enable {
      programs.ssh.extraConfig = ''
        Host eu.nixbuild.net
          PubkeyAcceptedKeyTypes ssh-ed25519
          ServerAliveInterval 60
          IdentityFile ${config.mySystem.core.nixbuild.identityFile}
      '';

      programs.ssh.knownHosts = {
        nixbuild = {
          hostNames = ["eu.nixbuild.net"];
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
        };
      };

      nix = {
        distributedBuilds = true;
        buildMachines = [
          {
            hostName = "eu.nixbuild.net";
            system = "x86_64-linux";
            maxJobs = 100;
            supportedFeatures = ["benchmark" "big-parallel"];
          }
        ];
      };
    };
  };
}
