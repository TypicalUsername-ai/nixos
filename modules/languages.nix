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
    ruff
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
