{ pkgs }:
let
  fakturamaskinen = pkgs.callPackage
    /home/mathias/code/projects/fakturamaskinen
    { inherit pkgs; };
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
      ExecStart = "${fakturamaskinen}/bin/fakturamaskinen -address localhost:8513";
      WorkingDirectory = "/var/www/faktura.magnusson.space";
    };
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
  };
}
