{ config, lib, pkgs, inputs, ... }:

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
];

environment.variables.EDITOR = "nvim";
}
