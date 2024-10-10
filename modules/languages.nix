{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
	deno
	rustup
	python3
    clang
];

environment.variables.EDITOR = "nvim";
}
