{ pkgs, ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "niversesu";
      user.email = "niversesu@gmail.com";
      init.defaultBranch = "main";
    };
  };
}
