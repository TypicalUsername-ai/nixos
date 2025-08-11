# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/terminal-utils.nix
    #../../modules/languages.nix
    #../../modules/devtools.nix
    #../../modules/cybersec-cli.nix
    ../../modules/containers.nix
  ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "rpi-homelab"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  ## wireguard and firewall config from [nixos docs]()
  # enable NAT
  networking = {
      nat = {
          enable = true;
          externalInterface = "end0";
      };
      firewall = {
          enable = true;
          allowedTCPPorts = [
              22 # ssh
              80 # http
              443 # https
          ];
      };
  };

  
# Dynamic DNS systemd service

# virtualisation socket settings
  virtualisation.podman.networkSocket = {
      enable = true;
      openFirewall = true;
      port = 2376;
      listenAddress = "0.0.0.0";
      server = "ghostunnel";
      tls = {
          cacert = "/home/matt/podman_tls/ca.pem";
          key = "/home/matt/podman_tls/server-key.pem";
          cert = "/home/matt/podman_tls/server-cert.pem";
      };
  };

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  environment.systemPackages = with pkgs; [
    openssl
    mold
  ];

  users.users.matt = {
    isNormalUser = true;
    home = "/home/matt";
    extraGroups = [ 
        "wheel" #sudo
        "podman" #podman socket access
        ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "without-password";
      };
  services.fail2ban.enable = true;

  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
