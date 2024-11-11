{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    ## Javascript / Typescript
    deno
    ## rust
    rustup
    ## python
    python3
    ## c++
    clang
    ## markdown
    vale
    ## lua style formatting
    stylua
    ## nix style formatting
    nixfmt-rfc-style
  ];

  environment.variables.EDITOR = "nvim";
}
