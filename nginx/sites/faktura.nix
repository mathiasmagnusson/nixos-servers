{ pkgs }:
let
  fakturamaskinen = pkgs.callPackage /var/www/faktura.magnusson.space/build.nix { inherit pkgs; };
in
{
  name = "faktura.magnusson.space";

  virtualHost = {
    locations."/" = {
      proxyPass = "http://localhost:8513";
    };
  };

  systemdService = {
    description = "Fakturamaskinen";
    unitConfig = {
      StartLimitIntervalSec = 10;
    };
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = 10;
      ExecStart = "${fakturamaskinen}/bin/fakturamaskinen";
      WorkingDirectory = "/var/www/faktura.magnusson.space";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
  };
}
