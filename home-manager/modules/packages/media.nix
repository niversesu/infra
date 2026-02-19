{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    gimp3-with-plugins
    kdePackages.kdenlive
    qpwgraph
  ];
}
