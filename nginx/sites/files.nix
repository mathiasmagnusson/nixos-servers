{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.files;
in
{
  options.elevate.websites.www = {
    enable = mkEnableOption "http file server";
  };

  config = mkIf cfg.enable {
    services.nginx.virtualHosts."files.magnusson.space" = {
      forceSSL = true;
      useACMEHost = "magnusson.space";

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
