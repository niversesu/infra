# Proxy configuration for NixOS
{ config, pkgs, ... }:

{
  # System-wide proxy environment variables
  environment.variables = {
    http_proxy = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
    https_proxy = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
    ftp_proxy = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
    HTTP_PROXY = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
    HTTPS_PROXY = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
    FTP_PROXY = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
    no_proxy = "localhost,127.0.0.1,::1,.local";
    NO_PROXY = "localhost,127.0.0.1,::1,.local";
  };

  # NetworkManager proxy configuration (affects KDE network settings)
  networking.proxy = {
    default = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
    noProxy = "localhost,127.0.0.1,::1,.local";
  };

  # Git proxy configuration
  programs.git = {
    enable = true;
    config = {
      http.proxy = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
      https.proxy = "http://brd-customer-hl_811c730a-zone-67-country-ke:9dbyv2lb4b40@brd.superproxy.io:33335";
    };
  };
}