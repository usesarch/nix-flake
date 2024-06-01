{
	description = "Declan's laptop flake";

	inputs = {
	 nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
        };

	outputs = {self, nixpkgs }:
	let
          lib =nixpkgs.lib;
	  system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
	    config.allowUnfree = true;
          };
	in {
	  nixosConfigurations = {
	    laptop = lib.nixosSystem {
	      inherit system;
	      modules = [ ./configuration.nix ];

	  };
	};

      };
}
