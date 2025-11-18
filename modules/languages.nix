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
    svelte-language-server
    ## rust
    rust-bin.stable.latest.default
    rust-analyzer
    ## python
    python3
    ## c++
    clang
    ## typst
    typst
    ## go
    go
  ];

  environment.variables.EDITOR = "nvim";
}
