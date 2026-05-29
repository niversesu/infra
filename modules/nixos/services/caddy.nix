{...}: {
  flake.nixosModules.caddy = {
    config,
    lib,
    ...
  }: {
    # No global 'enable' option needed here; we want it to be demand-driven
    config = lib.mkIf (config.services.caddy.virtualHosts != {}) {
      services.caddy = {
        enable = true;
      };
      # Open firewall for HTTP/HTTPS if Caddy is active
      networking.firewall.allowedTCPPorts = [80 443];
    };
  };
}
