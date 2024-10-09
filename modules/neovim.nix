{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
	neovim
];

environment.variables.EDITOR = "nvim";
}
