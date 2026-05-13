{pkgs, ...}: {
  flake.nixosModules.core-shell = {
    config,
    lib,
    ...
  }: {
    options.mySystem.core.shell.enable = lib.mkEnableOption "Core Shell Integration (Fish, Sudo-rs)";
    config = lib.mkIf config.mySystem.core.shell.enable {
      security.sudo-rs.enable = true;
      environment.sessionVariables.XDG_DATA_DIRS = [
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
        "${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
      ];
      programs.bash = {
        interactiveShellInit = ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${config.programs.fish.package}/bin/fish $LOGIN_OPTION
          fi
        '';
      };
    };
  };
}
