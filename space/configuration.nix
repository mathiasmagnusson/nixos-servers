{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../nginx
      ../nginx/sites/faktura.nix
      ./certificates.nix
    ];

  elevate.websites.faktura.enable = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";

  networking.hostName = "space"; # Define your hostname.
  networking.usePredictableInterfaceNames = false;
  networking.nameservers = [ "1.1.1.1" ];

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  users.users.mathias = {
    isNormalUser = true;
    home = "/home/mathias";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPC69ml72mqbn7L3QkpsCJuWdrKFYFNd0MaS5xERbuSF mathias@pingu-arch"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAO88bhtrgWXg4zY8jIAVqzyHKa+PNJRpLbyk86y4Glc mathias@taplop"
    ];
  };

  environment.systemPackages = with pkgs; [
    neovim
    git

    inetutils
    mtr
    sysstat
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
    settings.PasswordAuthentication = false;
    ports = [ 69 ];
  };

  # Linode longview
  services.longview = {
    enable = true;
    apiKeyFile = "/var/lib/secrets/longview";
  };

  security.sudo.wheelNeedsPassword = false;

  # Enable firewall. Some services automatically open ports they use
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}

