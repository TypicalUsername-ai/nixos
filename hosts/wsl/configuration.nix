# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/terminal-utils.nix
    ../../modules/languages.nix
    ../../modules/devtools.nix
    ../../modules/cybersec-cli.nix
    ../../modules/containers.nix
    ../../modules/python.nix
    inputs.nixos-wsl.nixosModules.wsl
    # include NixOS-WSL modules
  ];

  environment.systemPackages = with pkgs; [
    wl-clipboard
    mold
  ];

  users.users.matt = {
    isNormalUser = true;
    home = "/home/matt";
    extraGroups = [ "wheel" ];
  };

  wsl = {
    enable = true;
    defaultUser = "matt";
    docker-desktop = {
      enable = true;
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
