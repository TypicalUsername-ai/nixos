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
          internalInterfaces = [ "wg0" ];
      };
      firewall = {
          enable = true;
          allowedUDPPorts = [
              51820 # wireguard
          ];
          allowedTCPPorts = [
              22 # ssh
              80 # http
              443 # https
          ];
      };
  };

  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg0 = {
      # Determines the IP address and subnet of the server's end of the tunnel interface.
      ips = [ "10.100.0.1/24" ];

      # The port that WireGuard listens to. Must be accessible by the client.
      listenPort = 51820;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE
      '';

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/home/matt/wireguard/private_key";

      peers = [
        # List of allowed peers.
        {
          # SM 55a PHONE
          # Public key of the peer (not a file path).
          publicKey = "eQNsO1CDUkVJuobv68Ep270KoSpw1hXgVAWoFsQ2D3Y=";
          # List of IPs assigned to this peer within the tunnel subnet. Used to configure routing.
          allowedIPs = [ "10.100.0.2/32" ];
        }

      ];
    };
  };

# Dynamic DNS systemd service
  systemd.services = {
      dynamic-dns-updater = {
          path = [
              pkgs.curl
          ];
          script = "/home/matt/noip/update.sh";
          startAt = "hourly";
      };
  };

# virtualisation socket settings
  #virtualisation.podman.networkSocket = {
  #    enable = true;
  #    openFirewall = true;
  #    port = 2376;
  #    listenAddress = "0.0.0.0";
  #    server = "ghostunnel";
      #tls = {
      #    cacert = "/home/matt/podman_tls/authority.pem";
      #    key = "/home/matt/podman_tls/ca.key";
      #    cert = "/home/matt/podman_tls/socket_cert.pem";
      #};
  #};

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  environment.systemPackages = with pkgs; [
    openssl
    mold
    # add wireguard packages
    # wireguard-go #!! broken
    # pkgs.linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
  ];

  users.users.matt = {
    isNormalUser = true;
    home = "/home/matt";
    extraGroups = [ "wheel" ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.fail2ban.enable = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
