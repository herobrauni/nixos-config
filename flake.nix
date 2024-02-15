{
  description = "brauni NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    lanzaboote,
    ...
  }: {
    nixosConfigurations = {
      envy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        boot.lanzaboote = {
          enable = true;
          pkiBundle = "/share/secureboot";
        };
        modules = [
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
          ./hosts/envy
          # home-manager.nixosModules.home-manager
          # {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;

          #   home-manager.extraSpecialArgs = inputs;
          #   home-manager.users.brauni = import ./hosts/envy/home.nix;
          # }
        ];
      };
    };
  };
}
