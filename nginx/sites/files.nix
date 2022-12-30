{ pkgs }:
{
  name = "files.magnusson.space";

  virtualHost = {
    root = "/var/www/files.magnusson.space";
    extraConfig = ''
      autoindex on;
      location ~ /\. {
        autoindex off;
      }
    '';
  };
}
