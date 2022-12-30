{ pkgs }:
{
  name = "rr.magnusson.space";

  virtualHost = {
    root = "/var/www/rr.magnusson.space";
    locations."/" = {
      index = "index.mp4";
    };
  };
}
