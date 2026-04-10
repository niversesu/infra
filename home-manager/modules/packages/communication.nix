{ self, ... }: {
  flake.homeModules.pkg-communication = {
    description = "Communication tools: Discord, Slack";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ discord slack ];
    }) ];
  };
}
