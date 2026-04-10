{ self, ... }: {
  flake.homeModules.git = {
    description = "Home-manager git configuration with personal defaults";
    imports = [
      ({ config, pkgs, lib, ... }: {
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
      })
    ];
  };
}
