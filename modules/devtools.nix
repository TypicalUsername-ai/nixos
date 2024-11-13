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
    ## Rust-specific consider moving or abstracting to option TODO
    bacon
    cargo-tarpaulin
    cargo-nextest
  ];

  environment.variables.EDITOR = "nvim";
}
