{

  description = "My First Flake";
  
  inputs = {
    nixpkgs.url = "nixpkgs/release-25.05";
  };

  outputs = { self, nixpkgs, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        tns-slx-n10469 = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix ];
        };
      };
    };

}
