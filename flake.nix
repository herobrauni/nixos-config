{
  description = "brauni NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , agenix
    , impermanence
    , lanzaboote
    , NixOS-WSL
    , flake-parts
    , ...
    }: {
      nixosConfigurations = {
        envy = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            impermanence.nixosModules.impermanence
            lanzaboote.nixosModules.lanzaboote
            ./hosts/envy
          ];
        };
        deskbrauni = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            impermanence.nixosModules.impermanence
            ./hosts/deskbrauni
          ];
        };
        ocismall1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/ocismall1
          ];
        };
        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/wsl
            NixOS-WSL.nixosModules.wsl
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # home-manager.users.brauni = import ./home;
            }
          ];
        };
      };
    };
}
