{
  description = "Flake nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    stylix.url = "github:danth/stylix/release-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }:
  let 
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages."x86_64-linux";
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
 	system = "x86_64-linux";
        modules = [ stylix.nixosModules.stylix ./configuration.nix ];
      };
    };
    homeConfigurations = {
  # virtualisation.virtualbox.guest.draganddrop = true;
      lxudrr = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/home.nix ];#stylix.homeManagerModules.stylix ./home/home.nix ];
      };
    };
  };

}

