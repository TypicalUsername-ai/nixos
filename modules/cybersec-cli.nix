{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    nmap
    dig
    torsocks
    syft
    grype
    openvpn
    inetutils
    netcat
    gobuster
    mitmproxy
    tcpdump
    openssl
    metasploit
    hashcat
  ];

  environment.variables.EDITOR = "nvim";
}
