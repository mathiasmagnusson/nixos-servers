{
  default = true;

  serverName = "magnusson.space";
  serverAliases = [ "www.magnusson.space" ];

  root = "/var/www/www.magnusson.space";
  locations."/" = {
    index = "index.html";
  };
}
