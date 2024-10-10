{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
    nmap
    syft
    grype
];

environment.variables.EDITOR = "nvim";
}
