{
  description = "brauni NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    impermanence,
    ...
  }: {
    nixosConfigurations = {
      envy = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          impermanence.nixosModules.impermanence
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
