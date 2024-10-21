{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
    nmap
    dig
    torsocks
    syft
    grype
];

environment.variables.EDITOR = "nvim";
}
