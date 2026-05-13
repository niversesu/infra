{...}: {
  flake.homeModules.vscode = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.myHome.vscode.enable = lib.mkEnableOption "vscode";
    config = lib.mkIf config.myHome.vscode.enable {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
      };
    };
  };
}
