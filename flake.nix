{

  description = "My First Flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/release-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        tns-slx-n10469 = lib.nixosSystem {
	  inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {
        ron = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home.nix ];
        };
      };
    };

}
