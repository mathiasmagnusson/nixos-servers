{
  serverName = "files.magnusson.space";

  root = "/var/www/files.magnusson.space";
  extraConfig = ''
    autoindex on;
    location ~ /\. {
      autoindex off;
    }
  '';
}
