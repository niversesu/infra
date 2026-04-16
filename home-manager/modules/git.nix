{ self, ... }: {
  flake.homeModules.git = { config, pkgs, lib, ... }: {
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
  };
}
