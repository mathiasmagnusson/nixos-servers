{ pkgs }:
{
  name = "magnusson.space";

  virtualHost = {
    default = true;

    serverAliases = [ "www.magnusson.space" ];

    root = "/var/www/www.magnusson.space";
    locations."/" = {
      index = "index.html";
    };
  };
}
