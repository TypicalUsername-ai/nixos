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
let
  pythonEnv = pkgs.python313.withPackages (ps: [
    ps.numpy
    ps.polars
    ps.jupyter
    ps.matplotlib
    ps.pytorch
    ps.requests
    ps.python-lsp-server
  ]);
in
{

  environment.systemPackages = with pkgs; [
    pythonEnv
  ];
}
