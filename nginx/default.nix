{ config, pkgs, ... }:
let
  # sslCertificateKey = "/var/lib/secrets/magnusson.space.key";
  # sslCertificate = "/var/lib/secrets/magnusson.space.crt";

  sites = [
    (import ./sites/www.nix     { inherit pkgs; })
    (import ./sites/files.nix   { inherit pkgs; })
    (import ./sites/rr.nix      { inherit pkgs; })
  ];
in
{
  services.nginx.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx.virtualHosts = builtins.listToAttrs (map (s: {
    name = s.name;
    value = {
      forceSSL = true;
      /* inherit sslCertificateKey sslCertificate; */
      useACMEHost = "magnusson.space";
    } // s.virtualHost;
  }) sites);

  systemd.services = builtins.listToAttrs (map (s: {
  	name = s.name;
    value = s.systemdService;
  }) (builtins.filter (s: s ? systemdService) sites));
}
