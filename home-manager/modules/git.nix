{...}: {
  flake.homeModules.git = {pkgs, lib, config, ...}: {
    options.myHome.git.enable = lib.mkEnableOption "git";
    config = lib.mkIf config.myHome.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user.name = "niversesu";
        user.email = "niversesu@gmail.com";
        init.defaultBranch = "main";

        url."git@github.com:".insteadOf = [
          "https://github.com/"
          "git://github.com/"
        ];
      };
    };
    home.packages = with pkgs; [git-lfs];
    };
  };
}
