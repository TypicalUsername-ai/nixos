{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    # For automatically installing the rust toolchain
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      rust-overlay,
      ...
    }@inputs:
    {
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/wsl/configuration.nix
          #        ({pkgs, ... }): {
          #                   nixpkgs.overlays = [ rust-overlay.overlays.default ];
          #                   environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          #             }
          home-manager.nixosModules.home-manager
          {
            home-manager.users.matt = import ./home.nix;
          }
        ];
      };
      nixosConfigurations.rpi-homelab = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/rpi-homelab/configuration.nix
          #        ({pkgs, ... }): {
          #                   nixpkgs.overlays = [ rust-overlay.overlays.default ];
          #                   environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          #             }
          home-manager.nixosModules.home-manager
          {
            home-manager.users.matt = import ./home.nix;
          }
        ];
      };

    };

}
