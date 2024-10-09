{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
	neovim
	docker
];

environment.variables.EDITOR = "nvim";
}
