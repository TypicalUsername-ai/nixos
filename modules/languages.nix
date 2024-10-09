{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
	deno
	rustup
	python3
];

environment.variables.EDITOR = "nvim";
}
