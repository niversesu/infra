{ pkgs, ... }: {
  programs.starship = {
  enable = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.enableInteractive = true;
  };
}


