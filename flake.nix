{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/wsl/configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };

  homeConfigurations = {
      host1_user = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.x86_64-linux;
        homeDirectory = "/home/matt";  # Replace with actual username
        user = "matt";  # Replace with actual username
        modules = [
          ./hosts/matt/home.nix  # Link to the host-specific home.nix
        ];
      };
      };
  };



}
