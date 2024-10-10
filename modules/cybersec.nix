{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
    nmap
    ghidra
];

environment.variables.EDITOR = "nvim";
}
