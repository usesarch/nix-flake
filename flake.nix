{
  description = "Declan's laptop flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        laptop = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix inputs.stylix.nixosModules.stylix ];
        };
      };

    };
}
