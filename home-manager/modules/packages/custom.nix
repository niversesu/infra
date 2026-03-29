{pkgs, nur, ...}: {
  home.packages = with pkgs; [
    pkgs.nur.repos.ataraxiasjel.waydroid-script
    antigravity-fhs
  ];
}
