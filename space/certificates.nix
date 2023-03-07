# https://nixos.org/manual/nixos/stable/index.html#module-security-acme
{ config, pkgs, ... }:
{
  security.acme.acceptTerms = true;
  security.acme.defaults = {
    dnsProvider = "linode";
    email = "mathias@magnusson.space";
    credentialsFile = "/var/lib/secrets/linode-dns-api-key.ini";
  };

  security.acme.certs = {
    "magnusson.space" = {
      extraDomainNames = [ "*.magnusson.space" ];
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
