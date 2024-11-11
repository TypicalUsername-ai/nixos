{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    neovim
    docker
    bacon
  ];

  environment.variables.EDITOR = "nvim";
}
