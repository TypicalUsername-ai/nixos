{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
    nmap
];

environment.variables.EDITOR = "nvim";
}
