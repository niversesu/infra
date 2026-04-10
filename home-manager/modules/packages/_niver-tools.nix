{ self, ... }: {
  flake.homeModules.pkg-nivertools = {
    description = "Development tools for Niver: Kubernetes, Go, Python";
    imports = [ ({ pkgs, ... }: {
      home.packages = with pkgs; [ gh kubectl kubelogin-oidc k9s python3 go ];
    }) ];
  };
}
