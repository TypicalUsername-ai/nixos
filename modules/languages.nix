{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
	deno
	rustup
];

environment.variables.EDITOR = "nvim";
}
