{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.elevate.websites.nginx;
in
{
  options.elevate.websites.nginx = {
    enable = mkEnableOption "http file server";
  };

  config = mkIf cfg.enable {
    services.nginx.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
