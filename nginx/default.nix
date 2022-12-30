{ config, pkgs, ... }:
let
  sslCertificateKey = "/var/lib/secrets/tls-certificate/privkey.pem";
  sslCertificate = "/var/lib/secrets/tls-certificate/fullchain.pem";

  sites = [
    (import ./sites/www.nix     { inherit pkgs; })
    (import ./sites/files.nix   { inherit pkgs; })
    (import ./sites/rr.nix      { inherit pkgs; })
    (import ./sites/faktura.nix { inherit pkgs; })
  ];
in
{
  services.nginx.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx.virtualHosts = builtins.listToAttrs (map (s: {
    name = s.name;
    value = {
      forceSSL = true;
      inherit sslCertificateKey sslCertificate;
    } // s.virtualHost;
  }) sites);

  systemd.services = builtins.listToAttrs (map (s: {
  	name = s.name;
    value = s.systemdService;
  }) (builtins.filter (s: s ? systemdService) sites));
}
