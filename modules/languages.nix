{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  environment.systemPackages = with pkgs; [
    ## Javascript / Typescript
    deno
    ## rust
    rust-bin.stable.latest.default
    rust-analyzer
    ## python
    python3
    ## c++
    clang
    ## markdown
    vale
    ## lua style formatting
    stylua
    ## nix style formatting
    nixfmt-rfc-style
  ];

  environment.variables.EDITOR = "nvim";
}
