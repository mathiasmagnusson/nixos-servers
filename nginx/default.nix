{ config, pkgs, ... }:
let
  sslCertificateKey = "/var/lib/secrets/tls-certificate/privkey.pem";
  sslCertificate = "/var/lib/secrets/tls-certificate/fullchain.pem";

  sites = [
    (import ./sites/www.nix)
    (import ./sites/files.nix)
  ];
in
{
  services.nginx.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx.virtualHosts = builtins.listToAttrs (map (s: {
    name = s.serverName;
    value = {
      forceSSL = true;
      inherit sslCertificateKey sslCertificate;
    } // s;
  }) sites);
}
