{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
    ## Javascript / Typescript
	deno
    ## rust
	rustup
    rust-analyzer
    ## python
	python3
    ## c++
    clang
];

environment.variables.EDITOR = "nvim";
}
