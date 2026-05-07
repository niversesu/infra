{self, ...}: {
  flake.homeModules.user-amani = {...}: {
    imports = [
      self.homeModules.shared
    ];

    myHome.packages.gaming.enable = true;
    myHome.packages.creative.enable = true;
    myHome.packages.tech-tools.enable = true;
  };
}
