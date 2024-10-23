{ config, lib, pkgs, inputs, ... }:

{

environment.systemPackages = with pkgs; [
    nmap
    dig
    torsocks
    syft
    grype
    openvpn
];

environment.variables.EDITOR = "nvim";
}
