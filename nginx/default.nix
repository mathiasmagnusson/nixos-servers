{ config, pkgs, ... }:
let
  sslCertificateKey = "/var/lib/secrets/tls-certificate/privkey.pem";
  sslCertificate = "/var/lib/secrets/tls-certificate/fullchain.pem";
in
{
  services.nginx.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx.virtualHosts = {
    "magnusson.space" = {
      forceSSL = true;
      inherit sslCertificateKey sslCertificate;

      default = true;

      root = "/var/www/www.magnusson.space";
      locations."/" = {
        index = "index.html";
      };
    };

    "files.magnusson.space" = {
      forceSSL = true;
      inherit sslCertificateKey sslCertificate;

      root = "/var/www/files.magnusson.space";

      extraConfig = ''
      	autoindex on;
        location ~ /\. {
          autoindex off;
        }
      '';
    };
  };
}
