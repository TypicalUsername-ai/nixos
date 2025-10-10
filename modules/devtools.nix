{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    # neovim already in home.nix
    scc
    ## docker
    ## Rust-specific consider moving or abstracting to option TODO
    bacon
    cargo-tarpaulin
    cargo-nextest
    #
    kanidm_1_7
  ];

  environment.variables.EDITOR = "nvim";
}
