{ config, pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts = {
    "new.magnusson.space" = {
      default = true;
      locations."/" = {
        root = ./public;
        index = "index.html";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
