{ pkgs, ... }: {
  programs.starship = {
    enable = false;
    enableFishIntegration = true;
  };
}
