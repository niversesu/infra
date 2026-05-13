{...}: {
  flake.homeModules.git = {
    pkgs,
    lib,
    config,
    ...
  }: {
    options.myHome.git.enable = lib.mkEnableOption "git";
    config = lib.mkIf config.myHome.git.enable {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "niversesu";
            email = "niversesu@gmail.com";
          };
          alias = {
            # The "Ultimate" Log
            lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
            st = "status";
            co = "checkout";
            br = "branch";
            cm = "commit -m";
            ca = "commit -am";
            ps = "push";
            pl = "pull";
            unstage = "reset HEAD --";
            last = "log -1 HEAD";
          };
          init.defaultBranch = "main";
          pull.rebase = true;
          push.autoSetupRemote = true;
          core.editor = "nvim";
          url."git@github.com:".insteadOf = [
            "https://github.com/"
            "git://github.com/"
          ];
        };
      };
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          navigate = true;
          light = false;
          side-by-side = true;
          line-numbers = true;
        };
      };
      home.packages = with pkgs; [
        git-lfs
        lazygit
        gh
      ];
    };
  };
}
