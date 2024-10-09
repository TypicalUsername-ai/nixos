# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
	git
	neovim
	wget
	curl
	gitui
	eza
	bat
	dust
];

environment.variables.EDITOR = "nvim";
}
